import 'package:equatable/equatable.dart';
import 'package:tgg/models/waypoints/waypoint_behavior.dart';

class WaypointStep extends Equatable {
  final String id;
  final String title;
  final String instructions;
  final String missionId;
  final int position;
  final WaypointBehavior behavior;
  final int scoring;

  WaypointStep.fromJsonMap(Map<String, dynamic> map)
      : this.id = map["id"],
        this.title = map["title"],
        this.instructions = map["instructions"],
        this.missionId = map["mission_id"],
        this.position = map["position"],
        this.scoring = map["scoring"],
        this.behavior = WaypointBehavior.fromJsonMap(map["behavior"], map);

  @override
  List<Object> get props =>
      [id, title, instructions, missionId, position, behavior, scoring];
}
