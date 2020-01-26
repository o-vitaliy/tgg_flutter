import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/location_provider.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

import 'dao/dao_submission.dart';

class WaypointsRepo {
  final ApiProvider apiProvider;
  final DaoSubmission daoSubmission;
  final DaoMedia daoMedia;
  final LocationProvider locationProvider;

  WaypointsRepo({
    @required this.apiProvider,
    @required this.daoSubmission,
    @required this.daoMedia,
    @required this.locationProvider,
  });

  Future<List<Waypoint>> getActiveWaypoints() async {
    final response = await apiProvider.activeWaypoints();
    final map = json.decode(response);
    final mapped = map.map((w) => Waypoint.fromJsonMap(w));
    return List<Waypoint>.from(mapped);
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
            "location_fix": {
              "time": time.toIso8601String(),
              "coords": [
                location.latitude,
                location.longitude,
              ],
              "accuracy": location.accuracy.toInt()
            },
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

  Future submitAnswer(
    Waypoint waypoint,
    Iterable<WaypointSubmissionItem> items,
  ) async {
    final location = await locationProvider.getLocation();

    final waypointId = waypoint.id;
    final submission = await Future.wait(items.map((i) async => {
          i.submission.type:
              SubmissionTypeHelper.isMediaFromString(i.submission.type)
                  ? (await daoMedia.findByKey(i.answer)).mediaId
                  : i.answer,
        }));
    final medias = await Future.wait(items
        .where((i) => i.media != null)
        .map((i) async => (await daoMedia.findByKey(i.answer)).mediaId));
    final values = {
      "submissions": [
        {
          "time": DateTime.now().toIso8601String(),
          "submission": submission.toList(), //[{"text": "bird"}]
        }
      ],
      "num_hints_used": 0,
      "started_at": DateTime.now().toIso8601String(),
      "completed_at": DateTime.now().toIso8601String(),
      "completed_location": [
        location.latitude,
        location.longitude,
      ],
      "media": medias.toList() // []
    };
    return apiProvider.waypointTriggerAction(
      waypointId: waypointId,
      values: {"name": "sync", "params": values},
    );
  }
}
