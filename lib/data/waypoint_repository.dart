import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/data/dao/dao_answer.dart';
import 'package:tgg/data/dao/dao_hints.dart';
import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/dao/dao_waypoints.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/location_provider.dart';
import 'package:tgg/helpers/expandable_list.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

import 'dao/dao_submission.dart';
import 'dao/db.dart';

class WaypointsRepo {
  final ApiProvider apiProvider;
  final DaoSubmission daoSubmission;
  final DaoMedia daoMedia;
  final DaoAnswer daoAnswer;
  final DaoHint daoHint;
  final DaoWaypoint daoWaypoint;
  final LocationProvider locationProvider;

  WaypointsRepo({
    @required this.apiProvider,
    @required this.daoSubmission,
    @required this.daoMedia,
    @required this.daoAnswer,
    @required this.daoHint,
    @required this.daoWaypoint,
    @required this.locationProvider,
  });

  Future<List<Waypoint>> getActiveWaypoints() async {
    final response = await apiProvider.activeWaypoints();
    final map = json.decode(response);
    final mapped = map.map((w) => Waypoint.fromJsonMap(w)).toList();

    for (int i = 0; i < map.length; i++) {
      await _saveWaypoint(mapped[i], map[i]);
    }
    return List<Waypoint>.from(mapped, growable: false);
  }

  Future trackStart(String waypointId) {
    final time = DateTime.now();
    return Observable.fromFuture(locationProvider.getLocation())
        .doOnData((location) {
      apiProvider.waypointTriggerAction(
        waypointId: waypointId,
        values: {
          "name": "start",
          "params": {
            "started_at": time.toIso8601String(),
            "location_fix": locationProvider.toFix(location)
          }
        },
      );
    }).doOnData((location) {
      daoSubmission.insert(
        waypointId,
        time,
        location.latitude,
        location.longitude,
      );
    }).first;
  }

  Future submitAnswer(String waypointId) async {
    await daoWaypoint.savePassed(waypointId);

    final location = await locationProvider.getLocation();
    final hintsUsed = await daoHint.getUsedHints(waypointId);

    final Waypoint waypoint = Waypoint.fromJsonMap(
        json.decode((await daoWaypoint.getWaypoint(waypointId)).waypointJson));

    final medias = await _getMedias(waypointId);
    final submissions = await _getSubmissions(waypointId);

    final Map values = await Future.value({
      "submissions": submissions,
      "num_hints_used": hintsUsed,
      "started_at": DateTime.now().toIso8601String(),
      "completed_at":
          waypoint.step.behavior.type.generateCompletedAt()?.toIso8601String(),
      "completed_location": [
        location.latitude,
        location.longitude,
      ],
      "media": medias // []
    });
    await apiProvider.waypointTriggerAction(
      waypointId: waypointId,
      values: {"name": "sync", "params": values},
    );
    await daoWaypoint.saveSynced(waypointId);
  }

  String _getSubmitType(String type) {
    if (SubmissionTypeHelper.fromString(type) == SubmissionType.yesno) {
      return "choice";
    } else {
      return type;
    }
  }

  dynamic _getAnswerValue(String type, String answer) {
    return SubmissionTypeHelper.getTransformerFromString(type)
        .transform(answer);
  }

  Future _saveWaypoint(Waypoint waypoint, Map map) async {
    await daoWaypoint.insert(
        waypoint.id, ModeHelper.to(waypoint.mode), json.encode(map));
  }

  Future<List<String>> _getMedias(String waypointId) async {
    final allAnswers = await daoAnswer.getAnswersByWaypointId(waypointId);
    final medias = await Future.wait(
        allAnswers.map((i) async => (await daoMedia.findByUrl(i))));
    final mediasNotNull = medias.where((m) => m != null).map((m) {
      return m.mediaId;
    }).toList(growable: false);

    return mediasNotNull;
  }

  Future<List<Map>> _getSubmissions(String waypointId) async {
    final allAnswers = await daoAnswer.getAnswerList(waypointId);
    final Map<DateTime, List<AnswerTableData>> grouped =
        groupBy(allAnswers, (AnswerTableData e) => e.addedAt);
    final Map<String, String> answersToMedia = Map();

    for (int i = 0; i < allAnswers.length; i++) {
      MediaTableData media = await daoMedia.findByUrl(allAnswers[i].answer);
      if (media != null) {
        answersToMedia[allAnswers[i].answer] = media.mediaId;
      }
    }

    final result = grouped.keys.map((key) {
      final value = grouped[key];
      final List submission = value
          .where((e) => e.submissionType != null)
          .map((e) => {
                _getSubmitType(e.submissionType): answersToMedia[e.answer] ??
                    _getAnswerValue(e.submissionType, e.answer)
              })
          .toList();
      return {"time": key.toIso8601String(), "submission": submission};
    }).toList();
    return result;
  }
}
