import 'package:tgg/models/waypoints/waypoint_step.dart';

class Waypoint {
  final String id;
  final WaypointStep step;

  Waypoint.fromJsonMap(Map<String, dynamic> map)
      : this.id = map["id"],
        this.step = WaypointStep.fromJsonMap(map["step"]);
}
