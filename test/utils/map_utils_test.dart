import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/helpers/map_utils.dart';

import '../models/waypoints/waypoint_step_test.dart';

main() {
  group("utils", () {
    test("getAt with corrct path", () {
      final map = json.decode(mockedChoices);

      final result = getAt(map, "content.choices");
      expect(result, isNotNull);
      expect(result.length, 4);
      expect(result[2]["value"], true);
    });

    test("getAt with incorrct path", () {
      final map = json.decode(mockedChoices);

      expect(getAt(map, "content.choic!!!!es"), isNull);
      expect(getAt(map, "cont!!!!ent.choices"), isNull);
      expect(getAt(map, "cont!!!!ent.choi!!!!ces"), isNull);
    });

    test("getAt for empty map", () {
      expect(getAt({}, "content.choices"), isNull);
    });

    test("getAt for null map", () {
      expect(getAt(null, "content.choices"), isNull);
    });
  });
}
