import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/behavior_types.dart';
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
        expect(BehaviorTypeHelper.fromString(w.step.behavior.id), isNotNull);
      });
    });

    test("check all could be parsed", () {
      waypoints.forEach((w) {
        final type = BehaviorTypeHelper.fromString(w.step.behavior.id);
        expect(BehaviorTypeHelper.isVerified(type), isNotNull);
      });
    });

    test("noSubmissions", () {
      waypoints.forEach((w) {
        final type = BehaviorTypeHelper.fromString(w.step.behavior.id);
        expect(BehaviorTypeHelper.noSubmissions(type), isNotNull);
      });

      expect(BehaviorTypeHelper.noSubmissions(BehaviorType.info), true);
    });

    test("auto submit button", () {
      waypoints.forEach((w) {
        final type = w.step.behavior.id;
        expect(BehaviorTypeHelper.autoSubmit(type), isNotNull);
      });
      expect(BehaviorTypeHelper.autoSubmit("linked_head_to_head"), true);
    });

    test("postponedResult", () {
      waypoints.forEach((w) {
        final type = BehaviorTypeHelper.fromString(w.step.behavior.id);
        expect(BehaviorTypeHelper.postponedResult(type), isNotNull);
      });
      final result =
          BehaviorTypeHelper.postponedResult(BehaviorType.linked_head_to_head);
      expect(result, true);
    });
  });
}
