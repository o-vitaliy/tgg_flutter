import 'package:equatable/equatable.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

class Mission extends Equatable {
  final String id;
  final String name;

  Mission({this.id, this.name});

  Mission.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"];

  Mission.fromWaypoint(Waypoint waypoint)
      : id = waypoint.step.missionId,
        name = waypoint.step.title;

  @override
  List<Object> get props => [id, name];
}
