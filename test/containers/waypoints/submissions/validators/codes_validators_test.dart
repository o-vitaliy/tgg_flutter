import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/validate/codes_validators.dart';

main() {
  group("codes", () {
    test("custom ", () async {
      final validator = CodeCustomValidator(error: _customCodeError);
      final vars = ["1", "2", "3"];
      expect(validator.validate(null, variants: vars), _customCodeError);
      expect(validator.validate("a", variants: vars), _customCodeError);
      expect(validator.validate("1", variants: vars), null);
      expect(validator.validate("2", variants: vars), null);
      expect(validator.validate("3", variants: vars), null);
      expect(validator.validate("4", variants: vars), _customCodeError);
    });

    test("standard ", () async {
      final validator = CodeStandardValidator(error: _standardCodeError);
      expect(validator.validate(null), _standardCodeError);
      expect(validator.validate("a"), _standardCodeError);
      expect(validator.validate("6111"), null);
      expect(validator.validate("5111"), null);
      expect(validator.validate("4111"), null);
      expect(validator.validate("3111"), null);
      expect(validator.validate("2111"), null);
      expect(validator.validate("1111"), null);
      expect(validator.validate("311"), _standardCodeError);
    });
  });
}

const _customCodeError = "customCodeError";
const _standardCodeError = "standardCodeError";
