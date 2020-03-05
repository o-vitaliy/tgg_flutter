import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_parser_utils.dart';

main() {
  final Map<String, Object> map = {
    "content": {
      "string": "string_value",
      "bool": true,
      "bool_string": "true",
      "int": 1,
      "int_string": "1"
    }
  };

  group("getValue", () {
    test("empty map", () {
      final result = getValue(Map<String, Object>(), "key", (v) => v);
      expect(result, isNull);
    });

    test("get value", () {
      final result = getValue(map, "string", (v) => v);
      expect(result, "string_value");
    });
  });

  group("getString", () {
    test("not extisting key", () {
      final result = getStringValue(Map<String, Object>(), "not_existing_key");
      expect(result, isNull);
    });

    test("get string", () {
      final result = getStringValue(map, "string");
      expect(result, "string_value");
    });
  });

  group("getBoolValue", () {
    test("not extisting key", () {
      final result = getBoolValue(Map<String, Object>(), "not_existing_key");
      expect(result, false);
    });

    test("from bool", () {
      final result = getBoolValue(map, "bool");
      expect(result, true);
    });
    test("from string", () {
      final result = getBoolValue(map, "bool_string");
      expect(result, true);
    });
  });

  group("getIntValue", () {
    test("not extisting key", () {
      final result = getIntValue(Map<String, Object>(), "not_existing_key");
      expect(result, null);
    });

    test("from int", () {
      final result = getIntValue(map, "int");
      expect(result, 1);
    });
    test("from string", () {
      final result = getIntValue(map, "int_string");
      expect(result, 1);
    });
  });
}
