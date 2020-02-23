import 'package:tgg/models/waypoints/waypoint.dart';

class WaypointsStartLoadAction {}

class WaypointsStartedLoadingAction {}

class WaypointsCompletedLoadingAction {
  final List<Waypoint> waypoints;

  WaypointsCompletedLoadingAction(this.waypoints);
}

class WaypointsSelectCurrentAction {
  final Waypoint waypoint;

  WaypointsSelectCurrentAction(this.waypoint);
}
