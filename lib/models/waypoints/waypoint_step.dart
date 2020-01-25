import 'package:tgg/models/waypoints/waypoint_behavior.dart';

class WaypointStep {
  final String id;
  final String title;
  final String instructions;
  final String missionId;
  final int position;
  final WaypointBehavior behavior;

  WaypointStep.fromJsonMap(Map<String, dynamic> map)
      : this.id = map["id"],
        this.title = map["title"],
        this.instructions = map["instructions"],
        this.missionId = map["mission_id"],
        this.position = map["position"],
        this.behavior = WaypointBehavior.fromJsonMap(map["behavior"], map);
}
