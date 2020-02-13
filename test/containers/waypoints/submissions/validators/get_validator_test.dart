import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/behavior_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/submissions_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/text_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';

main() {
  group("getValidator", () {
    test("check if all types are covered", () {
      BehaviorType.values.forEach((type) {
        final result = getValidator(type);
        expect(result, isInstanceOf<Validator>());
      });
    });

    test("has valadator", () async {
      expect(getValidator(BehaviorType.text_answer),
          isInstanceOf<TextValidator>());
      expect(getValidator(BehaviorType.number_answer),
          isInstanceOf<NumberValidator>());
      expect(getValidator(BehaviorType.multiple_choice),
          isInstanceOf<RadioValidator>());
      expect(getValidator(BehaviorType.many_choices),
          isInstanceOf<CheckboxesValidator>());
    });

    test("has valadator", () async {
      final noValidatorTypes = [
        BehaviorType.text_unverified,
        BehaviorType.number_unverified,
        BehaviorType.multiple_choice_points,
        BehaviorType.photo,
        BehaviorType.photo_and_text,
        BehaviorType.photo_and_text_pair,
        BehaviorType.photo_sequence,
        BehaviorType.photo_and_text_sequence,
        BehaviorType.movie,
        BehaviorType.movie_and_text,
      ];

      noValidatorTypes.forEach((type) {
        expect(getValidator(BehaviorType.photo), isInstanceOf<NoValidator>());
      });
    });
  });
}
