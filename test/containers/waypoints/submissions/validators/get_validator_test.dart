import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/submissions_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/text_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';

main() {
  group("getValidator", () {
    test("text", () async {
      expect(getValidator(SubmissionType.text), isInstanceOf<TextValidator>());
    });

    test("photo", () async {
      expect(
          getValidator(SubmissionType.photo), isInstanceOf<EmptyValidator>());
    });

    test("number", () async {
      expect(
          getValidator(SubmissionType.number), isInstanceOf<NumberValidator>());
    });

    test("choice", () async {
      expect(
          getValidator(SubmissionType.choice), isInstanceOf<RadioValidator>());
    });

    test("checkboxes", () async {
      expect(getValidator(SubmissionType.checkboxes),
          isInstanceOf<CheckboxesValidator>());
    });

    test("movie", () async {
      expect(
          getValidator(SubmissionType.movie), isInstanceOf<EmptyValidator>());
    });
  });
}
