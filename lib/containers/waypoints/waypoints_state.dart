import 'package:tgg/models/waypoints/waypoint.dart';

class WaypointsState {
  final bool isLoading;
  final List<Waypoint> activeWaypoints;

  WaypointsState({this.isLoading, this.activeWaypoints});

  WaypointsState copyWith({bool isLoading, List<Waypoint> activeWaypoints}) =>
      WaypointsState(
        isLoading: isLoading != null ? isLoading : this.isLoading,
        activeWaypoints: activeWaypoints ?? this.activeWaypoints,
      );

  factory WaypointsState.initial() {
    return WaypointsState(isLoading: false);
  }
}
