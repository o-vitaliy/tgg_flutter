import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/validate/choice_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/text_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/variant_validator.dart';

import '../../../../models/waypoints/submission_choice_test.dart';

main() {
  group("validators", () {
    test("emptyText", () async {
      final validator = EmptyValidator(error: emptyTextError);
      expect(validator.validate(null), emptyTextError);
      expect(validator.validate(""), emptyTextError);
      expect(validator.validate("value"), null);
    });

    test("no validatation", () async {
      final validator = NoValidator();
      expect(validator.validate(null), isNull);
      expect(validator.validate(""), isNull);
      expect(validator.validate("value"), isNull);
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

    test("validate all сhoices checked ", () async {
      final validator = CheckboxesValidator(error: invalidChoiceError);
      expect(validator.validate(null, variants: mockedChoices),
          invalidChoiceError);
      expect(validator.validate(["first"], variants: mockedChoices),
          invalidChoiceError);
      expect(validator.validate(["correct"], variants: mockedChoices),
          invalidChoiceError);
      expect(validator.validate(["first", "correct"], variants: mockedChoices),
          isNull);
      expect(validator.validate(["correct", "first"], variants: mockedChoices),
          isNull);
    });

    test("validate radio", () async {
      final validator = RadioValidator(error: invalidChoiceError);
      expect(validator.validate(null, variants: mockedChoices),
          invalidChoiceError);
      expect(validator.validate("first", variants: mockedChoices), isNull);
      expect(validator.validate("correct", variants: mockedChoices), isNull);
      expect(validator.validate("second", variants: mockedChoices),
          invalidChoiceError);
      expect(validator.validate("last", variants: mockedChoices),
          invalidChoiceError);
    });

    test("validate variant ", () async {
      final validator = VariantValidator(error: invalidVariantError);
      final variants = ["Hello", "hello world"];
      expect(validator.validate(null, variants: variants), invalidVariantError);

      //short word one typo -> error
      expect(
          validator.validate("Helo", variants: variants), invalidVariantError);

      //long word two typos -> error
      expect(validator.validate("hallo warld", variants: variants),
          invalidVariantError);

      //short word no typo -> ok
      expect(validator.validate("hello", variants: variants), null);

      //long word no typo -> ok
      expect(validator.validate("hello world", variants: variants), null);
      //long word one typo -> ok
      expect(validator.validate("hello world", variants: variants), null);
    });
    test("validate text ", () async {
      final validator = TextValidator(
          emptyTextError: emptyTextError, invalidError: invalidVariantError);
      final variants = ["Hello", "hello world"];

      expect(validator.validate(null, variants: null), emptyTextError);
      expect(validator.validate("value", variants: null), null);

      //short word one typo -> error
      expect(
          validator.validate("Helo", variants: variants), invalidVariantError);

      //long word two typos -> error
      expect(validator.validate("hallo warld", variants: variants),
          invalidVariantError);

      //short word no typo -> ok
      expect(validator.validate("hello", variants: variants), null);

      //long word no typo -> ok
      expect(validator.validate("hello world", variants: variants), null);
      //long word one typo -> ok
      expect(validator.validate("hello world", variants: variants), null);
    });
  });
}

const emptyTextError = "emptyTextError";
const invalidEmailError = "invalidEmailError";
const invalidNumberError = "invalidNumberError";
const invalidChoiceError = "invalidChoiceError";
const invalidVariantError = "invalidVariantError";
