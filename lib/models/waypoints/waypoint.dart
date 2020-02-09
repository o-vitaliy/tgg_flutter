import 'package:tgg/models/waypoints/waypoint_step.dart';

class Waypoint {
  final String id;
  final WaypointStep step;
  final int points;

  Waypoint.fromJsonMap(Map<String, dynamic> map)
      : this.id = map["id"],
        this.points = map.containsKey("points")? map["points"] : 0,
        this.step = WaypointStep.fromJsonMap(map["step"]);
}
