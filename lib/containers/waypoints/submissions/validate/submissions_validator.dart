import 'package:tgg/containers/waypoints/submissions/behavior_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/text_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';

Validator getValidator(BehaviorType type) {
  switch (type) {
    case BehaviorType.text_answer:
      return TextValidator();
    case BehaviorType.number_answer:
      return NumberValidator();
    case BehaviorType.multiple_choice:
      return RadioValidator();
    case BehaviorType.many_choices:
      return CheckboxesValidator();

    case BehaviorType.text_unverified:
    case BehaviorType.number_unverified:
    case BehaviorType.multiple_choice_points:
    case BehaviorType.photo:
    case BehaviorType.photo_and_text:
    case BehaviorType.photo_and_text_pair:
    case BehaviorType.photo_sequence:
    case BehaviorType.photo_and_text_sequence:
    case BehaviorType.movie:
    case BehaviorType.movie_and_text:
    case BehaviorType.movie_pair:
    case BehaviorType.camera:
    case BehaviorType.profile_team_name:
    case BehaviorType.profile_phone:
    case BehaviorType.profile_multiple_choice:
    case BehaviorType.profile_other:
    case BehaviorType.profile_photo:
    case BehaviorType.info:
    case BehaviorType.linked_head_to_head:
    case BehaviorType.code_custom:
      return NoValidator();
    default:
      throw ArgumentError("unsupported type $type");
  }
}

String validate(BehaviorType type, dynamic answer, variants) {
  return getValidator(type).validate(answer, variants: variants);
}

String validateList(BehaviorType type, List<WaypointSubmissionItem> items,
    {String separator = ", "}) {
  final result = items
      .map((i) => validate(type, i.answer, i.submission.choices))
      .where((v) => v != null);

  return result == null || result.isEmpty ? null : result.join(separator);
}
