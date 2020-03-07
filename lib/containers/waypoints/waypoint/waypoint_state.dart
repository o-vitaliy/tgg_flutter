import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

class WaypointState {
  WaypointState._();

  Map<String, WaypointItemState> _map = Map<String, WaypointItemState>();

  bool containsKey(String key) => _map.containsKey(key);

  WaypointItemState operator [](String key) => _map[key];

  void operator []=(String key, WaypointItemState state) {
    _map.removeWhere(
        (key, value) => value.waypoint.mode == state.waypoint.mode);
    _map[key] = state;
  }

  void put(String key, WaypointItemState state) => this[key] = state;

  void remove(String key) => _map.remove(key);

  Waypoint getWaypointForType(Mode mode) => _map.values
      ?.firstWhere((w) => w.waypoint.mode == mode, orElse: () => null)
      ?.waypoint;

  factory WaypointState.initial() {
    return WaypointState._();
  }
}
