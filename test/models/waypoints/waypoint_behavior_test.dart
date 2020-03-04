import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_behavior.dart';

main() {
  group("waypoint behavior", () {
    test("fromJsonMap All modes", () {
      final behaviorJson =
          File("test/data/mocks/behavior.json").readAsStringSync();
      final map = json.decode(behaviorJson);
      final behaviors = map["results"];
      behaviors.forEach((w) {
        final behavior = WaypointBehavior.fromJsonMap(w, {});
        expect(behavior.type, isNotNull);
        expect(behavior.description, isNotNull);
      });
    });

    test("fromJsonMap All types", () {
      final behaviorJson =
          File("test/data/mocks/behavior.json").readAsStringSync();
      final map = json.decode(behaviorJson);
      final behaviors = map["results"];

      final list = List<String>();
      behaviors.forEach((w) {
        try {
          final behavior = WaypointBehavior.fromJsonMap(w, {});
          expect(behavior.type, isNotNull);
        } catch (e) {
          list.add(w["id"]);
        }
      });

      expect(list, []);
    });
  });
}
