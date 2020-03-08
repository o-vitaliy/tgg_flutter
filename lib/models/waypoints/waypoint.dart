import 'package:equatable/equatable.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/models/waypoints/waypoint_step.dart';

class Waypoint extends Equatable {
  final String id;
  final WaypointStep step;
  final int missionPoints;
  final int missionStepsCount;
  final Mode mode;

  Waypoint.fromJsonMap(Map<String, dynamic> map)
      : this.id = map["id"],
        this.missionPoints =
            map.containsKey("mission_points") ? map["mission_points"] : 0,
        this.step = WaypointStep.fromJsonMap(map["step"]),
        this.missionStepsCount =
            map.containsKey("steps_count") ? map["steps_count"] : 1,
        this.mode = ModeHelper.fromString(map["mode_name"]);

  @override
  List<Object> get props => [id, step, missionPoints, missionStepsCount, mode];
}
