import 'package:meta/meta.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

@immutable
abstract class MissionStartLoadAction {
  MissionStartLoadAction();
}

@immutable
class LoadMissionWaypointAction {
  final String missionId;

  LoadMissionWaypointAction(this.missionId);
}

@immutable
class LoadedMissionWaypointAction {
  final Waypoint waypoint;

  LoadedMissionWaypointAction(this.waypoint);
}
