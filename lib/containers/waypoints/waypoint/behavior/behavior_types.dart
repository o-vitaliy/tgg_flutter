import 'package:tgg/containers/waypoints/waypoint/behavior/behaviors.dart';

class BehaviorTypeHelper {
  static BaseBehaviorType fromString(final String value) {
    switch (value) {
      case "text_answer":
        return TextAnswerBehaviorType();
      case "text_unverified":
        return TextUnverifiedBehaviorType();
      case "number_answer":
        return NumberAnswerBehaviorType();
      case "number_unverified":
        return NumberUnverifiedBehaviorType();
      case "multiple_choice":
        return MultipleChoiceBehaviorType();
      case "multiple_choice_points":
        return MultipleChoicePointBehaviorType();
      case "many_choices":
        return ManyChoicesPointBehaviorType();
      case "photo":
        return PhotoBehaviorType();
      case "photo_pair":
        return PhotoPairBehaviorType();
      case "photo_and_text":
        return PhotoAndTextBehaviorType();
      case "photo_and_text_pair":
        return PhotoAndTextPairBehaviorType();
      case "photo_sequence":
        return PhotoSequenceBehaviorType();
      case "photo_and_text_sequence":
        return PhotoAndTextSequenceBehaviorType();
      case "movie":
        return MovieBehaviorType();
      case "movie_and_text":
        return MovieAndTextBehaviorType();
      case "movie_pair":
        return MoviePairBehaviorType();
      case "camera":
        return CameraBehaviorType();
      case "profile_team_name":
        return ProfileTeamNameBehaviorType();
      case "profile_phone":
        return ProfilePhoneBehaviorType();
      case "profile_other":
        return ProfileOtherBehaviorType();
      case "profile_multiple_choice":
        return ProfileMultiChoiceBehaviorType();
      case "profile_photo":
        return ProfilePhotoBehaviorType();
      case "info":
        return InfoBehaviorType();
      case "linked_head_to_head":
        return LinkedHeadToHeadBehaviorType();
      case "code_custom":
        return CodeCustomBehaviorType();
      case "code_standard":
        return CodeStandardBehaviorType();
      case "endless_photo":
        return EndlessPhotoBehaviorType();
      case "endless_movie":
        return EndlessMovieBehaviorType();
      case "endless_camera":
        return EndlessCameraBehaviorType();
      case "plant_score_lowest":
        return PlantScoreLowestBehaviorType();
      case "plant_score_highest":
        return PlantScoreHighestBehaviorType();
      case "stall":
        return StallBehaviorType();
      case "profile_other_number":
        return ProfileOtherNumberBehaviorType();
      case "survey":
        return SurveyBehaviorType();
      case "worksheet":
        return WorksheetBehaviorType();
      case "closest_number":
        return ClosestNumberBehaviorType();
      case "redirect":
        return RedirectBehaviorType();

      default:
        throw ArgumentError("unsupported behavior type $value");
    }
  }
}
