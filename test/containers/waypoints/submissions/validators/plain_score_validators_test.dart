import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/validate/plain_score_validator.dart';

main() {
  group("plain score", () {
    test("check", () async {
      final validator = PlainScoreValidator(error: _error);
      final vars = ["1111"];

      expect(validator.validate(null, variants: vars), _error);
      expect(validator.validate("", variants: vars), _error);
      expect(validator.validate("null", variants: vars), _error);
      expect(validator.validate("1111", variants: vars), null);
    });
  });
}

const _error = "error";
