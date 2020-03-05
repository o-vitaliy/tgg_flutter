import 'package:meta/meta.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';

@immutable
class PointsCalculateAction {}

@immutable
class PointsRemoteUpdateAction {
  final double points;

  PointsRemoteUpdateAction(this.points);
}

@immutable
class PointsWaypointSubmittedAction {
  final WaypointItemState waypointState;

  PointsWaypointSubmittedAction(this.waypointState);
}

@immutable
class PointsAddChallengeAction {
  final String waypointId;
  final double points;

  PointsAddChallengeAction(this.waypointId, this.points);
}

@immutable
class PointsUpdatedAction {
  final double points;

  PointsUpdatedAction(this.points);
}
