import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

import '../../../data/mocks.dart';

main() {
  List<Waypoint> waypoints;
  setUpAll(() {
    waypoints = List<Waypoint>.from(
        json.decode(mockedActiveWaypoints).map((w) => Waypoint.fromJsonMap(w)))
      ..addAll(List<Waypoint>.from(json
          .decode(File("test/data/mocks/activeWaypointAllModes.json")
              .readAsStringSync())
          .map((w) => Waypoint.fromJsonMap(w))));
  });

  group("type_from_string", () {
    test("check all could be parsed", () {
      waypoints = List<Waypoint>.from(json
          .decode(mockedActiveWaypoints)
          .map((w) => Waypoint.fromJsonMap(w)));

      waypoints.forEach((w) {
        expect(w.step.behavior.type, isNotNull);
      });
    });
  });
}
