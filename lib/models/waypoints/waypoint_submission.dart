import 'package:tgg/helpers/map_utils.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class WaypointSubmission {
  final String type;
  final String defaultPlaceholder;
  final String placeholder;
  final choices;
  final List<String> variants;

  WaypointSubmission._({
    this.type,
    this.defaultPlaceholder,
    this.placeholder,
    this.choices,
    this.variants,
  });

  static List<WaypointSubmission> from(dynamic map, {step}) {
    List<WaypointSubmission> result = List();
    if (map is Map) {
      result.add(WaypointSubmission._fromMap(map, step: step));
    } else if (map is String) {
      result.add(WaypointSubmission._fromString(map, step: step));
    } else if (map is List) {
      result.addAll(map.expand((m) => WaypointSubmission.from(m, step: step)));
    }
    return result;
  }

  static WaypointSubmission _fromMap(Map<String, dynamic> map, {step}) {
    return WaypointSubmission._(
      type: map["type"],
      defaultPlaceholder: map["default_placeholder"],
      placeholder: map["placeholder"],
      choices: SubmissionChoice.from(getAt(step, map["choices"])) ??
          _getTextVariants(step),
    );
  }

  static WaypointSubmission _fromString(String type, {step}) {
    return WaypointSubmission._(type: type, choices: _getTextVariants(step));
  }

  static List<String> _getTextVariants(step) {
    final variants =
        getAt(step, "content.correct")?.split(",")?.map((v) => v.trim());
    return variants != null ? List<String>.from(variants) : null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaypointSubmission &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          defaultPlaceholder == other.defaultPlaceholder &&
          placeholder == other.placeholder;

  @override
  int get hashCode =>
      type.hashCode ^ defaultPlaceholder.hashCode ^ placeholder.hashCode;
}
