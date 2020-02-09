import 'package:tgg/helpers/map_utils.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointBehavior {
  final String id;
  final String title;
  final String description;
  final List<WaypointSubmission> submissionType;
  final int numAttempts;
  final List<String> hints;

  WaypointBehavior.fromJsonMap(
      Map<String, dynamic> map, Map<String, dynamic> step)
      : this.id = map["id"],
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
    final value = getAt(step, "content.$key");
    if (value != null) return int.tryParse(value);
    final fieldValue = getField(key, "default", step);
    return fieldValue != null ? fieldValue as int : null;
  }

  static List<String> getHints(step) {
    final value = getAt(step, "content.hints");
    return value != null ? List<String>.from(value) : null;
  }

  static dynamic getField(String key, String valueKey, step) {
    final List fields = getAt(step, "behavior.fields");
    final value =
        fields.firstWhere((field) => field["name"] == key, orElse: () => null);
    if (value != null) {
      return value[valueKey];
    }
    return null;
  }
}
