import 'package:flutter/foundation.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

class WaypointState {
  final Waypoint waypoint;
  final List<WaypointSubmissionItem> items;

  WaypointState({
    @required this.waypoint,
    @required this.items,
  });

  WaypointState copyWith({
    Waypoint waypoint,
    List<WaypointSubmissionItem> items,
  }) =>
      WaypointState(
        waypoint: waypoint ?? this.waypoint,
        items: items ?? this.items,
      );
}
