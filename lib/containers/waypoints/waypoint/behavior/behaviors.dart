import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/codes_validators.dart';
import 'package:tgg/containers/waypoints/submissions/validate/plain_score_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/text_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';

import 'validation_result.dart';

abstract class BaseBehaviorType {
  String get type;

  bool get autoSubmit => false;

  bool get hasNoSubmissions => false;

  bool get endless => false;

  bool get postponedResult => false;

  ValidationResult isValid(List<WaypointSubmissionItem> items) => null;

  DateTime generateCompletedAt() => DateTime.now();
}

class TextAnswerBehaviorType extends BaseBehaviorType {
  @override
  String get type => "text_answer";

  @override
  ValidationResult isValid(List<WaypointSubmissionItem> items) {
    final String answer = items.first.answer;
    final List<String> variants = items.first.submission.choices;
    return ValidationResult.init(
        TextValidator().validate(answer, variants: variants), answer);
  }
}

class TextUnverifiedBehaviorType extends BaseBehaviorType {
  @override
  String get type => "text_unverified";
}

class NumberAnswerBehaviorType extends BaseBehaviorType {
  @override
  String get type => "number_answer";

  @override
  ValidationResult isValid(List<WaypointSubmissionItem> items) {
    final String answer = items.first.answer;
    final List<String> variants = items.first.submission.choices;
    return ValidationResult.init(
        CompositeValidator([NumberValidator(), TextValidator()])
            .validate(answer, variants: variants),
        answer);
  }
}

class NumberUnverifiedBehaviorType extends BaseBehaviorType {
  @override
  String get type => "number_unverified";
}

class MultipleChoiceBehaviorType extends BaseBehaviorType {
  @override
  String get type => "multiple_choice";

  @override
  ValidationResult isValid(List<WaypointSubmissionItem> items) {
    final answer = items.first.answer;
    final variants = items.first.submission.choices;
    return ValidationResult.init(
        RadioValidator().validate(answer, variants: variants), answer);
  }
}

class MultipleChoicePointBehaviorType extends BaseBehaviorType {
  @override
  String get type => "multiple_choice_points";
}

class ManyChoicesPointBehaviorType extends BaseBehaviorType {
  @override
  String get type => "many_choices";

  @override
  ValidationResult isValid(List<WaypointSubmissionItem> items) {
    final answer = items.first.answer;
    final variants = items.first.submission.choices;
    return ValidationResult.init(
        CheckboxesValidator().validate(answer, variants: variants),
        answer?.join(","));
  }
}

class PhotoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo";
}

class PhotoPairBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_pair";
}

class PhotoAndTextBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_and_text";
}

class PhotoAndTextPairBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_and_text_pair";
}

class PhotoSequenceBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_sequence";
}

class PhotoAndTextSequenceBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_and_text_sequence";
}

class MovieBehaviorType extends BaseBehaviorType {
  @override
  String get type => "movie";
}

class MovieAndTextBehaviorType extends BaseBehaviorType {
  @override
  String get type => "movie_and_text";
}

class MoviePairBehaviorType extends BaseBehaviorType {
  @override
  String get type => "movie_pair";
}

class CameraBehaviorType extends BaseBehaviorType {
  @override
  String get type => "camera";
}

class ProfileTeamNameBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_team_name";
}

class ProfilePhoneBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_phone";
}

class ProfileOtherBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_other";
}

class ProfileMultiChoiceBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_multiple_choice";
}

class ProfilePhotoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_photo";
}

class InfoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "info";

  @override
  bool get hasNoSubmissions => true;
}

class LinkedHeadToHeadBehaviorType extends BaseBehaviorType {
  @override
  String get type => "linked_head_to_head";

  @override
  bool get postponedResult => true;

  @override
  DateTime generateCompletedAt() => null;
}

class CodeCustomBehaviorType extends BaseBehaviorType {
  @override
  String get type => "code_custom";

  @override
  ValidationResult isValid(List<WaypointSubmissionItem> items) {
    final item = items.first;
    final value = item.answer;
    return ValidationResult.init(
        CodeCustomValidator()
            .validate(value, variants: item.submission.choices),
        value);
  }
}

class CodeStandardBehaviorType extends BaseBehaviorType {
  @override
  String get type => "code_standard";

  @override
  ValidationResult isValid(List<WaypointSubmissionItem> items) {
    final item = items.first;
    final String value = item.answer;
    return ValidationResult.init(
        CodeStandardValidator().validate(value), value);
  }
}

class EndlessPhotoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "endless_photo";

  @override
  bool get endless => true;
}

class EndlessMovieBehaviorType extends BaseBehaviorType {
  @override
  String get type => "endless_movie";

  @override
  bool get endless => true;
}

class EndlessCameraBehaviorType extends BaseBehaviorType {
  @override
  String get type => "endless_camera";

  @override
  bool get endless => true;
}

class PlantScoreLowestBehaviorType extends BaseBehaviorType {
  @override
  String get type => "plant_score_lowest";
}

class PlantScoreHighestBehaviorType extends BaseBehaviorType {
  @override
  String get type => "plant_score_highest";

  @override
  ValidationResult isValid(List<WaypointSubmissionItem> items) {
    final item = items[1];
    final String password = item.answer;
    return ValidationResult.init(
        PlainScoreValidator()
            .validate(password, variants: item.submission.choices),
        password);
  }
}

class StallBehaviorType extends BaseBehaviorType {
  @override
  String get type => "stall";

  @override
  bool get endless => true;
}

class ProfileOtherNumberBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_other_number";
}

class SurveyBehaviorType extends BaseBehaviorType {
  @override
  String get type => "survey";
}

class WorksheetBehaviorType extends BaseBehaviorType {
  @override
  String get type => "worksheet";
}

class ClosestNumberBehaviorType extends BaseBehaviorType {
  @override
  String get type => "closest_number";
}

class RedirectBehaviorType extends BaseBehaviorType {
  @override
  String get type => "redirect";

  @override
  bool get endless => true;
}
