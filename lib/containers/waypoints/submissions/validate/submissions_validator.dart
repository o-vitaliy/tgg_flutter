import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/text_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';

Validator getValidator(SubmissionType type) {
  switch (type) {
    case SubmissionType.text:
      return TextValidator();
    case SubmissionType.photo:
    case SubmissionType.movie:
      return EmptyValidator();
    case SubmissionType.number:
      return NumberValidator();
    case SubmissionType.choice:
      return RadioValidator();
    case SubmissionType.checkboxes:
      return CheckboxesValidator();
    default:
      throw ArgumentError("unsupported type $type");
  }
}

String validate(SubmissionType type, dynamic answer, variants) {
  return getValidator(type).validate(answer, variants: variants);
}

String validateList(List<WaypointSubmissionItem> items,
    {String separator = ", "}) {
  final result = items
      .map((i) => validate(SubmissionTypeHelper.fromString(i.submission.type),
          i.answer, i.submission.choices))
      .where((v) => v != null);

  return result == null || result.isEmpty ? null : result.join(separator);
}
