import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/helpers/levenshtein.dart';

main() {
  group("levenshtein", () {
    test("Hello vs Hallo", () {
      int distance = levenshtein('Hello', 'Hallo', caseSensitive: false);

      expect(distance, 1);
    });
    test("Hello vs hello", () {
      int distance = levenshtein('Hello', 'hello', caseSensitive: false);

      expect(distance, 0);
    });
    test("hello vs hello", () {
      int distance = levenshtein('hello', 'hello', caseSensitive: false);

      expect(distance, 0);
    });

    test("Hello vs hello", () {
      int distance = levenshtein('hello', 'halo', caseSensitive: false);

      expect(distance, 2);
    });
  });

  group("normalizedDistance", () {
    test("Hello vs Hallo", () {
      double ratio = normalizedDistance('Hello', 'Hallo', caseSensitive: false);
      expect(ratio, 0.2);
    });
    test("Hello vs hello", () {
      double ratio = normalizedDistance('Hello', 'hello', caseSensitive: false);

      expect(ratio, 0.0);
    });
    test("hello vs hello", () {
      double ratio = normalizedDistance('hello', 'hello', caseSensitive: false);

      expect(ratio, 0.0);
    });

    test("hello vs halo", () {
      double ratio = normalizedDistance('hello', 'halo', caseSensitive: false);

      expect(ratio, 0.4);
    });
  });
}
