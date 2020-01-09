import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';

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
  });
}

const emptyTextError = "emptyTextError";
const invalidEmailError = "invalidEmailError";
