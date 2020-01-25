import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointBehavior {
  final String id;
  final String title;
  final String description;
  final List<WaypointSubmission> submissionType;

  WaypointBehavior.fromJsonMap(
      Map<String, dynamic> map, Map<String, dynamic> step)
      : this.id = map["id"],
        this.title = map["title"],
        this.description = map["description"],
        this.submissionType = WaypointSubmission.from(
          map["submission_type"],
          step: step,
        );
}
