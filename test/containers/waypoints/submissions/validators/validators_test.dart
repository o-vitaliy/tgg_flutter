import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';

import '../../../../models/waypoints/submission_choice_test.dart';

main() {
  group("validators", () {
    test("emptyText", () async {
      final validator = EmptyValidator(error: emptyTextError);
      expect(validator.validate(null), emptyTextError);
      expect(validator.validate(""), emptyTextError);
      expect(validator.validate("value"), null);
    });

    test("email", () async {
      final validator = EmailValidator(error: invalidEmailError);
      expect(validator.validate(null), invalidEmailError);
      expect(validator.validate(""), invalidEmailError);
      expect(validator.validate("value"), invalidEmailError);
      expect(validator.validate("value@@dom.dd.dd"), invalidEmailError);
      expect(validator.validate("valid@com.dd"), null);
      expect(validator.validate("valid.valid@com.dd"), null);
    });

    test("both text and email", () async {
      final separator = ",";
      final validator = CompositeValidator(separator, [
        EmptyValidator(error: emptyTextError),
        EmailValidator(error: invalidEmailError)
      ]);

      expect(validator.validate(null),
          [emptyTextError, invalidEmailError].join(separator));
      expect(validator.validate(""),
          [emptyTextError, invalidEmailError].join(separator));
      expect(validator.validate("value"), invalidEmailError);
      expect(validator.validate("valid.valid@com.dd"), null);
    });

    test("validate number ", () async {
      final validator = NumberValidator(error: invalidNumberError);
      expect(validator.validate(null), invalidNumberError);
      expect(validator.validate(""), invalidNumberError);
      expect(validator.validate("aqaq"), invalidNumberError);
      expect(validator.validate("."), invalidNumberError);
      expect(validator.validate("0.1a"), invalidNumberError);
      expect(validator.validate("1"), null);
      expect(validator.validate("111"), null);
      expect(validator.validate("111.1"), null);
      expect(validator.validate("111."), null);
    });

    test("validate сhoice ", () async {
      final validator = ChoiceValidator(error: invalidChoiceError);
      expect(validator.validate(null, variants: mocked), invalidChoiceError);
      expect(
          validator.validate(["first"], variants: mocked), invalidChoiceError);
      expect(validator.validate(["correct"], variants: mocked),
          invalidChoiceError);
      expect(
          validator.validate(["first", "correct"], variants: mocked), isNull);
      expect(
          validator.validate(["correct", "first"], variants: mocked), isNull);
    });
  });
}

const emptyTextError = "emptyTextError";
const invalidEmailError = "invalidEmailError";
const invalidNumberError = "invalidNumberError";
const invalidChoiceError = "invalidChoiceError";
