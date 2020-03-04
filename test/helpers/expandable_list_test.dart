import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/helpers/expandable_list.dart';

main() {
  group("expandable_list", () {
    test("map indexed", () {
      final List<String> list = ["a", "b"];
      int i = 0;
      final result = list.mapIndex((value, index) {
        expect(index, i);
        expect(value, list[i]);
        i++;
        return index;
      }).toList(growable: false);

      expect(listEquals(result, [0, 1]), true);
    });

    test("foreach indexed", () {
      final List<String> list = ["a", "b"];
      int i = 0;
      list.forEachIndex((value, index) {
        expect(index, i);
        expect(value, list[i]);
        i++;
      });
    });
    test("foreach indexed", () {
      final List<String> list = ["a", "b"];
      dynamic result = list.firstOrNull((v) => v == "a");
      expect(result, "a");

      result = list.firstOrNull((v) => v == "c");
      expect(result, isNull);
    });
  });

  group("group by", () {
    test("test1", () {
      final list = [
        {"key": "key_1", "value": 1},
        {"key": "key_1", "value": 2},
        {"key": "key_2", "value": 3},
      ];

      final Map grouped = groupBy(list, (e) => e["key"]);
      expect(grouped.length, 2);
      expect(grouped.keys, ["key_1", "key_2"]);
      expect(grouped["key_1"][0]["value"], 1);
      expect(grouped["key_1"][1]["value"], 2);
      expect(grouped["key_2"][0]["value"], 3);
    });
  });
}
