import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/behavior.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/behaviors.dart';

List<String> _types = [
  "text_answer",
  "text_unverified",
  "number_answer",
  "number_unverified",
  "multiple_choice",
  "multiple_choice_points",
  "many_choices",
  "photo",
  "photo_pair",
  "photo_and_text",
  "photo_and_text_pair",
  "photo_sequence",
  "photo_and_text_sequence",
  "movie",
  "movie_and_text",
  "movie_pair",
  "camera",
  "profile_team_name",
  "profile_phone",
  "profile_other",
  "profile_multiple_choice",
  "profile_photo",
  "info",
  "linked_head_to_head",
  "code_custom",
  "code_standard",
  "endless_photo",
  "endless_movie",
  "endless_camera",
  "plant_score_lowest",
  "plant_score_highest",
  "plant_score_highest",
  "stall",
  "profile_other_number",
  "survey",
  "worksheet",
  "redirect"
];

main() {
  group("check all", () {
    test("missed", () {
      List missedTypes = List();
      _types.forEach((element) {
        final BaseBehaviorType behavior =
            BehaviorTypeHelper.fromString(element);
        if (behavior == null) missedTypes.add(element);
      });
      expect(missedTypes, []);
    });

    test("check one by one", () {
      expect(BehaviorTypeHelper.fromString("text_answer"),
          isInstanceOf<TextAnswerBehaviorType>());
      expect(BehaviorTypeHelper.fromString("text_unverified"),
          isInstanceOf<TextUnverifiedBehaviorType>());
      expect(BehaviorTypeHelper.fromString("number_answer"),
          isInstanceOf<NumberAnswerBehaviorType>());
      expect(BehaviorTypeHelper.fromString("number_unverified"),
          isInstanceOf<NumberUnverifiedBehaviorType>());

      expect(BehaviorTypeHelper.fromString("multiple_choice"),
          isInstanceOf<MultipleChoiceBehaviorType>());
      expect(BehaviorTypeHelper.fromString("multiple_choice_points"),
          isInstanceOf<MultipleChoicePointBehaviorType>());
      expect(BehaviorTypeHelper.fromString("many_choices"),
          isInstanceOf<ManyChoicesPointBehaviorType>());
      expect(BehaviorTypeHelper.fromString("photo"),
          isInstanceOf<PhotoBehaviorType>());
      expect(BehaviorTypeHelper.fromString("photo_pair"),
          isInstanceOf<PhotoPairBehaviorType>());
      expect(BehaviorTypeHelper.fromString("photo_and_text"),
          isInstanceOf<PhotoAndTextBehaviorType>());
      expect(BehaviorTypeHelper.fromString("photo_and_text_pair"),
          isInstanceOf<PhotoAndTextPairBehaviorType>());
      expect(BehaviorTypeHelper.fromString("photo_sequence"),
          isInstanceOf<PhotoSequenceBehaviorType>());
      expect(BehaviorTypeHelper.fromString("photo_and_text_sequence"),
          isInstanceOf<PhotoAndTextSequenceBehaviorType>());
      expect(BehaviorTypeHelper.fromString("movie"),
          isInstanceOf<MovieBehaviorType>());
      expect(BehaviorTypeHelper.fromString("movie_and_text"),
          isInstanceOf<MovieAndTextBehaviorType>());
      expect(BehaviorTypeHelper.fromString("movie_pair"),
          isInstanceOf<MoviePairBehaviorType>());
      expect(BehaviorTypeHelper.fromString("camera"),
          isInstanceOf<CameraBehaviorType>());
      expect(BehaviorTypeHelper.fromString("profile_team_name"),
          isInstanceOf<ProfileTeamNameBehaviorType>());
      expect(BehaviorTypeHelper.fromString("profile_phone"),
          isInstanceOf<ProfilePhoneBehaviorType>());
      expect(BehaviorTypeHelper.fromString("profile_other"),
          isInstanceOf<ProfileOtherBehaviorType>());
      expect(BehaviorTypeHelper.fromString("profile_multiple_choice"),
          isInstanceOf<ProfileMultiChoiceBehaviorType>());
      expect(BehaviorTypeHelper.fromString("profile_photo"),
          isInstanceOf<ProfilePhotoBehaviorType>());
      expect(BehaviorTypeHelper.fromString("info"),
          isInstanceOf<InfoBehaviorType>());
      expect(BehaviorTypeHelper.fromString("linked_head_to_head"),
          isInstanceOf<LinkedHeadToHeadBehaviorType>());
      expect(BehaviorTypeHelper.fromString("code_custom"),
          isInstanceOf<CodeCustomBehaviorType>());
      expect(BehaviorTypeHelper.fromString("code_standard"),
          isInstanceOf<CodeStandardBehaviorType>());
      expect(BehaviorTypeHelper.fromString("endless_photo"),
          isInstanceOf<EndlessPhotoBehaviorType>());
      expect(BehaviorTypeHelper.fromString("endless_movie"),
          isInstanceOf<EndlessMovieBehaviorType>());
      expect(BehaviorTypeHelper.fromString("endless_camera"),
          isInstanceOf<EndlessCameraBehaviorType>());
      expect(BehaviorTypeHelper.fromString("plant_score_lowest"),
          isInstanceOf<PlantScoreLowestBehaviorType>());
      expect(BehaviorTypeHelper.fromString("plant_score_highest"),
          isInstanceOf<PlantScoreHighestBehaviorType>());
      expect(BehaviorTypeHelper.fromString("stall"),
          isInstanceOf<StallBehaviorType>());
      expect(BehaviorTypeHelper.fromString("profile_other_number"),
          isInstanceOf<ProfileOtherNumberBehaviorType>());
      expect(BehaviorTypeHelper.fromString("survey"),
          isInstanceOf<SurveyBehaviorType>());
      expect(BehaviorTypeHelper.fromString("worksheet"),
          isInstanceOf<WorksheetBehaviorType>());
      expect(BehaviorTypeHelper.fromString("closest_number"),
          isInstanceOf<ClosestNumberBehaviorType>());
      expect(BehaviorTypeHelper.fromString("redirect"),
          isInstanceOf<RedirectBehaviorType>());
    });
  });
}
