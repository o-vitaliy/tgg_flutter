import 'package:redux/redux.dart';
import 'package:tgg/data/base_mission_repo.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

class LoadMissionMiddlewareHelper {
  static Future<List<Mission>> loadMission(
    final Store<AppState> store,
    final BaseMissionRepo repo,
    final List<Waypoint> waypoints,
    final Mode mode,
  ) async {
    final teamId = store.state.team.id;
    final anytime = await repo.getMissions(teamId);
    final fromWayponts = waypoints
        .where((w) => w.mode == mode)
        .map((w) => Mission.fromWaypoint(w));

    final result = anytime.toList()..addAll(fromWayponts);
    return result;
  }

  static Future<Waypoint> getWaypointByMissionId(
    final Store<AppState> store,
    final String missionId,
  ) async {
    Waypoint waypoint = (await waypointsRepo.getActiveWaypoints())
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
