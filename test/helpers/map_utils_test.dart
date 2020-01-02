import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/helpers/map_utils.dart';

main() {
  group("utls", () {
    test("Merge maps works correctly 1", () {
      final m = {
        "a": 1,
        "b": 1,
        "ab": {"a": 1, "b": 1}
      };
      final m2 = {"b": 2, "c": 2};

      final merged = merge(m, m2);

      final expected = {
        "a": 1,
        "b": 2,
        "c": 2,
        "ab": {"a": 1, "b": 1}
      };

      expect(merged, expected);
    });

    test("Merge maps works correctly 2", () {
      final m = {
        "a": 1,
        "b": 1,
      };
      final m2 = {
        "b": 2,
        "c": 2,
        "ab": {"a": "1", "b": 1}
      };

      final merged = merge(m, m2);

      final expected = {
        "a": 1,
        "b": 2,
        "c": 2,
        "ab": {"a": "1", "b": 1}
      };

      expect(merged, expected);
    });

    test("Merge maps works correctly 3", () {
      final m = {
        "a": 1,
        "b": 1,
      };
      final m2 = {
        "b": 2,
        "c": 2,
        "ab": {
          "a": 1,
          "z": {"y": 1}
        }
      };

      final merged = merge(m, m2);

      final expected = {
        "a": 1,
        "b": 2,
        "c": 2,
        "ab": {
          "a": 1,
          "z": {"y": 1}
        }
      };

      expect(merged, expected);
    });
  });
}
