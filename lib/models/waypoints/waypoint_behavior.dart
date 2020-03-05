import 'package:tgg/containers/waypoints/waypoint/behavior/behavior.dart';
import 'package:tgg/helpers/map_utils.dart';
import 'package:tgg/models/waypoints/waypoint_parser_utils.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointBehavior {
  final BaseBehaviorType type;
  final String title;
  final String description;
  final List<WaypointSubmission> submissionType;
  final int numAttempts;
  final List<String> hints;
  final String failureMessage;
  final String successMessage;

  WaypointBehavior.fromJsonMap(
      Map<String, dynamic> map, Map<String, dynamic> step)
      : this.type = BehaviorTypeHelper.fromString(map["id"]),
        this.title = map["title"],
        this.description = map["description"],
        this.numAttempts = _getNumAttempts(step),
        this.successMessage = _getSuccessMessage(step),
        this.failureMessage = _getFailureMessage(step),
        this.hints = _getHints(step),
        this.submissionType = WaypointSubmission.from(
          map["submission_type"],
          step: step,
        );

  static int _getNumAttempts(step) {
    final key = "num_attempts";
    return getIntValue(step, key);
  }

  static String _getSuccessMessage(step) {
    final key = "success_message";
    return getStringValue(step, key);
  }

  static String _getFailureMessage(step) {
    final key = "failure_message";
    return getStringValue(step, key);
  }

  static List<String> _getHints(step) {
    final value = getAt(step, "content.hints");
    return value != null ? List<String>.from(value) : null;
  }
}
