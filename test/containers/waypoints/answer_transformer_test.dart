import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/answer_transformer.dart';

main() {
  group("boolean transformer", () {
    final BooleanTransformer transformer = new BooleanTransformer();
    test("from null", () async {
      expect(transformer.transform(null), false);
    });
    test("from string false", () async {
      expect(transformer.transform("false"), false);
    });
    test("from 0", () async {
      expect(transformer.transform(0), false);
    });
    test("from boolean true", () async {
      expect(transformer.transform(true), true);
    });
    test("from stringed true", () async {
      expect(transformer.transform("true"), true);
    });
    test("from 1", () async {
      expect(transformer.transform(1), true);
    });
  });
  group("String transformer", () {
    final StringTransformer transformer = new StringTransformer();
    test("from 1", () async {
      expect(transformer.transform(1), "1");
    });
    test("from false", () async {
      expect(transformer.transform(false), "false");
    });
    test("from text", () async {
      expect(transformer.transform("text"), "text");
    });
  });

  group("list transformer", () {
    final ListStringTransformer transformer = new ListStringTransformer();
    test("from 1", () async {
      expect(listEquals(transformer.transform(1), ["1"]), true);
    });
    test("from 1,1", () async {
      expect(listEquals(transformer.transform("1, 1"), ["1", "1"]), true);
    });
  });
}
