import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

import '../../data/mocks.dart';

main() {
  group("waypoint", () {
    test("fromJsonMap", () {
      (json.decode(mockedActiveWaypoints) as Iterable).forEach((w) {
        final waypoint = Waypoint.fromJsonMap(w);
        expect(waypoint.id, isNotNull);
        expect(waypoint.step, isNotNull);
        expect(waypoint.missionPoints, isNotNull);
        expect(waypoint.missionStepsCount, isNotNull);
        expect(waypoint.mode, isNotNull);
      });
    });

    test("fromJsonMap All modes", () {
      (json.decode(File("test/data/mocks/activeWaypointAllModes.json").readAsStringSync()) as Iterable).forEach((w) {
        final waypoint = Waypoint.fromJsonMap(w);
        expect(waypoint.id, isNotNull);
        expect(waypoint.step, isNotNull);
        expect(waypoint.missionPoints, isNotNull);
        expect(waypoint.missionStepsCount, isNotNull);
        expect(waypoint.mode, isNotNull);
      });
    });
  });
}
