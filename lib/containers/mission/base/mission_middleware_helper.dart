import 'package:redux/redux.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/redux_model/app_state.dart';

class LoadMissionMiddlewareHelper {
  static Future<Waypoint> getWaypointByMissionId(
    final Store<AppState> store,
    final String missionId,
  ) async {
    Waypoint waypoint = (await waypointsRepo.getLocalActiveWaypoints())
        .where((w) => w.step.missionId == missionId)
        .first;

    if (waypoint == null) {
      final teamId = store.state.team.id;
      await bonusRepo.startMission(teamId, missionId);
      waypoint = (await waypointsRepo.getActiveWaypoints())
          .where((w) => w.step.missionId == missionId)
          .first;
    }
    return waypoint;
  }
}
