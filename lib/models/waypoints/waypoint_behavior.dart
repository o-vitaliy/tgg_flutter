import 'package:equatable/equatable.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/behavior.dart';
import 'package:tgg/helpers/map_utils.dart';
import 'package:tgg/models/waypoints/waypoint_parser_utils.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointBehavior extends Equatable {
  final BaseBehaviorType type;
  final String title;
  final String description;
  final List<WaypointSubmission> submissionType;
  final int numAttempts;
  final List<String> hints;

  WaypointBehavior.fromJsonMap(
      Map<String, dynamic> map, Map<String, dynamic> step)
      : this.type = BehaviorTypeHelper.fromString(map["id"]),
        this.title = map["title"],
        this.description = map["description"],
        this.numAttempts = getNumAttempts(step),
        this.hints = getHints(step),
        this.submissionType = WaypointSubmission.from(
          map["submission_type"],
          step: step,
        );

  static int getNumAttempts(step) {
    final key = "num_attempts";
    return getIntValue(step, key);
  }

  static List<String> getHints(step) {
    final value = getAt(step, "content.hints");
    return value != null ? List<String>.from(value) : null;
  }

  @override
  List<Object> get props =>
      [type, title, description, submissionType, numAttempts, hints];
}
