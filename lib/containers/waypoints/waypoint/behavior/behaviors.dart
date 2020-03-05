import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/codes_validators.dart';
import 'package:tgg/containers/waypoints/submissions/validate/plain_score_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/text_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';

import 'success_coefficient.dart';
import 'validation_result.dart';

abstract class BaseBehaviorType {
  String get type;

  bool get autoSubmit => false;

  bool get hasNoSubmissions => false;

  bool get endless => false;

  bool get postponedResult => false;

  ValidationResult isValid(List<WaypointSubmissionItem> items) => null;

  DateTime generateCompletedAt() => DateTime.now();

  SuccessCoefficient get successCoefficient;
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

  @override
  SuccessCoefficient get successCoefficient => FixedAnswerSuccessCoefficient();
}

class TextUnverifiedBehaviorType extends BaseBehaviorType {
  @override
  String get type => "text_unverified";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
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

  @override
  SuccessCoefficient get successCoefficient => FixedAnswerSuccessCoefficient();
}

class NumberUnverifiedBehaviorType extends BaseBehaviorType {
  @override
  String get type => "number_unverified";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
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

  @override
  SuccessCoefficient get successCoefficient => FixedAnswerSuccessCoefficient();
}

class MultipleChoicePointBehaviorType extends BaseBehaviorType {
  @override
  String get type => "multiple_choice_points";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
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

  @override
  SuccessCoefficient get successCoefficient => FixedAnswerSuccessCoefficient();
}

class PhotoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class PhotoPairBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_pair";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class PhotoAndTextBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_and_text";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class PhotoAndTextPairBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_and_text_pair";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class PhotoSequenceBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_sequence";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class PhotoAndTextSequenceBehaviorType extends BaseBehaviorType {
  @override
  String get type => "photo_and_text_sequence";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class MovieBehaviorType extends BaseBehaviorType {
  @override
  String get type => "movie";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class MovieAndTextBehaviorType extends BaseBehaviorType {
  @override
  String get type => "movie_and_text";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class MoviePairBehaviorType extends BaseBehaviorType {
  @override
  String get type => "movie_pair";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class CameraBehaviorType extends BaseBehaviorType {
  @override
  String get type => "camera";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class ProfileTeamNameBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_team_name";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class ProfilePhoneBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_phone";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class ProfileOtherBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_other";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class ProfileMultiChoiceBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_multiple_choice";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class ProfilePhotoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_photo";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class InfoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "info";

  @override
  bool get hasNoSubmissions => true;

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class LinkedHeadToHeadBehaviorType extends BaseBehaviorType {
  @override
  String get type => "linked_head_to_head";

  @override
  bool get postponedResult => true;

  @override
  DateTime generateCompletedAt() => null;

  @override
  SuccessCoefficient get successCoefficient => PostponedSuccessCoefficient();
}

class CodeCustomBehaviorType extends BaseBehaviorType {
  static const codes = [
    "6111",
    "5111",
    "4111",
    "3111",
    "2111",
    "1111",
  ];

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

  @override
  SuccessCoefficient get successCoefficient => DistanceSuccessCoefficient();
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

  @override
  SuccessCoefficient get successCoefficient =>
      StandardDistanceSuccessCoefficient();
}

class EndlessPhotoBehaviorType extends BaseBehaviorType {
  @override
  String get type => "endless_photo";

  @override
  bool get endless => true;

  @override
  SuccessCoefficient get successCoefficient => PostponedSuccessCoefficient();
}

class EndlessMovieBehaviorType extends BaseBehaviorType {
  @override
  String get type => "endless_movie";

  @override
  bool get endless => true;

  @override
  SuccessCoefficient get successCoefficient => PostponedSuccessCoefficient();
}

class EndlessCameraBehaviorType extends BaseBehaviorType {
  @override
  String get type => "endless_camera";

  @override
  bool get endless => true;

  @override
  SuccessCoefficient get successCoefficient => PostponedSuccessCoefficient();
}

class PlantScoreLowestBehaviorType extends BaseBehaviorType {
  @override
  String get type => "plant_score_lowest";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
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

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class StallBehaviorType extends BaseBehaviorType {
  @override
  String get type => "stall";

  @override
  bool get endless => true;

  @override
  SuccessCoefficient get successCoefficient => PostponedSuccessCoefficient();
}

class ProfileOtherNumberBehaviorType extends BaseBehaviorType {
  @override
  String get type => "profile_other_number";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class SurveyBehaviorType extends BaseBehaviorType {
  @override
  String get type => "survey";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class WorksheetBehaviorType extends BaseBehaviorType {
  @override
  String get type => "worksheet";

  @override
  SuccessCoefficient get successCoefficient => FixedSuccessCoefficient();
}

class ClosestNumberBehaviorType extends BaseBehaviorType {
  @override
  String get type => "closest_number";

  @override
  SuccessCoefficient get successCoefficient => PostponedSuccessCoefficient();
}

class RedirectBehaviorType extends BaseBehaviorType {
  @override
  String get type => "redirect";

  @override
  bool get endless => true;

  @override
  SuccessCoefficient get successCoefficient => PostponedSuccessCoefficient();
}
