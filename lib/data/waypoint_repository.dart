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
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

import '../constants.dart';
import 'dao/dao_submission.dart';

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
    daoWaypoint.savePassed(waypointId);
    final location = await locationProvider.getLocation();
    final hintsUsed = await daoHint.getUsedHints(waypointId);

    final types = await daoAnswer.getAnswerSubmissionTypes(waypointId);
    final allAnswers = await daoAnswer.getAnswersByWaypointId(waypointId);
    final medias = await Future.wait(
        allAnswers.map((i) async => (await daoMedia.findByKey(i))));
    final mediasNotNull = medias.where((m) => m != null).map((m) {
      return m.mediaId;
    }).toList(growable: false);
    final Map values = await Future.value({
      "submissions": await Future.wait(types.map((type) async {
        final List list = await _getSubmission(waypointId, type);
        return {"time": DateTime.now().toIso8601String(), "submission": list};
      })),
      "num_hints_used": hintsUsed,
      "started_at": DateTime.now().toIso8601String(),
      "completed_at": DateTime.now().toIso8601String(),
      "completed_location": [
        location.latitude,
        location.longitude,
      ],
      "media": mediasNotNull.toList() // []
    });
    await apiProvider.waypointTriggerAction(
      waypointId: waypointId,
      values: {"name": "sync", "params": values},
    );
    await daoWaypoint.saveSynced(waypointId);
  }

  Future<List> _getSubmission(String waypointId, String type) async {
    List<String> answers = await daoAnswer.getAnswerByType(waypointId, type);
    return await Future.wait(
        answers.map((a) async => {type: await _getAnswerValue(type, a)}));
  }

  Future<dynamic> _getAnswerValue(String type, String answer) async {
    final submissionType = SubmissionTypeHelper.fromString(type);
    if (SubmissionTypeHelper.isMedia(submissionType)) {
      final media = (await daoMedia.findByKey(answer));
      return media != null ? media.mediaId : null;
    } else if (SubmissionTypeHelper.isMultiChoice(submissionType)) {
      return answer.split(answerDelimiter);
    } else {
      return answer;
    }
  }

  Future _saveWaypoint(Waypoint waypoint, Map map) async {
    await daoWaypoint.insert(
        waypoint.id, ModeHelper.to(waypoint.mode), json.encode(map));
  }
}
