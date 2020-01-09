import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';

const typeText = "text";

String validate(SubmissionType type, String answer) {
  switch (type) {
    case SubmissionType.text:
      return EmptyValidator().validate(answer);
    default:
      throw ArgumentError("unsupported type $type");
  }
}

String validateList(List<WaypointSubmissionItem> items,
    {String separator = ", "}) {
  final result = items
      .map((i) => validate(
          SubmissionTypeHelper.fromString(i.submission.type), i.answer))
      .where((v) => v != null);

  return result == null || result.isEmpty ? null : result.join(separator);
}
