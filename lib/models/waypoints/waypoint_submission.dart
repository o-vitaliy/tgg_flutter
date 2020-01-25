import 'package:tgg/helpers/map_utils.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

class WaypointSubmission {
  final String type;
  final String defaultPlaceholder;
  final String placeholder;
  final List<SubmissionChoice> choices;

  WaypointSubmission._({
    this.type,
    this.defaultPlaceholder,
    this.placeholder,
    this.choices,
  });

  static List<WaypointSubmission> from(dynamic map, {step}) {
    List<WaypointSubmission> result = List();
    if (map is Map) {
      result.add(WaypointSubmission._fromMap(map, step: step));
    } else if (map is String) {
      result.add(WaypointSubmission._fromString(map));
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
        choices: SubmissionChoice.from(getAt(step, map["choices"])));
  }

  static WaypointSubmission _fromString(String type) {
    return WaypointSubmission._(
      type: type,
    );
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
