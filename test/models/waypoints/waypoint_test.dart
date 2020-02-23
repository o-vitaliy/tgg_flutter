import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

import '../../data/mocks.dart';

Waypoint get _waypoint =>
    Waypoint.fromJsonMap(json.decode(mockedActiveWaypoints).first);

main() {
  group("waypoint", () {
    test("fromJsonMap", () {
      expect(_waypoint.id, isNotNull);
      expect(_waypoint.step, isNotNull);
      expect(_waypoint.points, isNotNull);
      expect(_waypoint.mode, isNotNull);
    });
  });
}
