import 'package:tgg/data/providers.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

class LoadMissionMiddlewareHelper {
  static Future<Waypoint> getWaypointByMissionId(
    final String teamId,
    final String missionId,
  ) async {
    Waypoint waypoint = (await waypointsRepo.getLocalActiveWaypoints(teamId))
        .where((w) => w.step.missionId == missionId)
        .first;

    if (waypoint == null) {
      await bonusRepo.startMission(teamId, missionId);
      waypoint = (await waypointsRepo.getActiveWaypoints(teamId))
          .where((w) => w.step.missionId == missionId)
          .first;
    }
    return waypoint;
  }
}
