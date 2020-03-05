import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/success_coefficient.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';

import '../../../../data/mocks.dart';

main() {
  group("FixedSuccessCoefficient", () {
    final SuccessCoefficient coefficient = FixedSuccessCoefficient();

    test("attemptsUsed: 0", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint("text_unverified"),
          items: getItems("text_unverified", [null]),
          hintsUsed: 0,
          attemptsUsed: 0));
      expect(result, 1);
    });
    test("attemptsUsed: 100", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint("text_unverified"),
          items: getItems("text_unverified", [null]),
          hintsUsed: 100,
          attemptsUsed: 100));
      expect(result, 1);
    });
  });
  group("PostponedSuccessCoefficient", () {
    final SuccessCoefficient coefficient = PostponedSuccessCoefficient();

    test("attemptsUsed: 0", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint("linked_head_to_head"),
          items: getItems("linked_head_to_head", [null]),
          hintsUsed: 0,
          attemptsUsed: 0));
      expect(result, 0);
    });
    test("attemptsUsed: 100", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint("linked_head_to_head"),
          items: getItems("linked_head_to_head", [null]),
          hintsUsed: 0,
          attemptsUsed: 100));
      expect(result, 0);
    });
  });

  group("FixedAnswerSuccessCoefficient", () {
    final SuccessCoefficient coefficient = FixedAnswerSuccessCoefficient();
    final type = "text_answer";

    test("attemptsUsed: 1", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, [null]),
          hintsUsed: 0,
          attemptsUsed: 1));
      expect(result, 1);
    });

    test("attemptsUsed == default valaue", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, [null]),
          hintsUsed: 0,
          attemptsUsed: 2));
      expect(result, 0.5);
    });

    test("attemptsUsed == default valaue", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, [null]),
          hintsUsed: 0,
          attemptsUsed: 3));
      expect(result, 0);
    });

    test("attemptsUsed more than default", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, [null]),
          hintsUsed: 0,
          attemptsUsed: 4));
      expect(result, 0);
    });
  });

  group("DistanceSuccessCoefficient", () {
    final SuccessCoefficient coefficient = DistanceSuccessCoefficient();
    final type = "code_custom";

    test("not valide code", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, [null]),
          hintsUsed: 0,
          attemptsUsed: 0));
      expect(result, 0);
    });

    test("as first code", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, ["1"]),
          hintsUsed: 0,
          attemptsUsed: 0));
      expect(result, .25);
    });

    test("as second code", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, ["2"]),
          hintsUsed: 0,
          attemptsUsed: 3));
      expect(result, .5);
    });
    test("as second third", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, ["3"]),
          hintsUsed: 0,
          attemptsUsed: 3));
      expect(result, .75);
    });

    test("as second third", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, ["4"]),
          hintsUsed: 0,
          attemptsUsed: 3));
      expect(result, 1);
    });
  });
  group("StandardDistanceSuccessCoefficient", () {
    final SuccessCoefficient coefficient = StandardDistanceSuccessCoefficient();
    final type = "code_standard";

    test("not valide code", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, [null]),
          hintsUsed: 0,
          attemptsUsed: 0));
      expect(result, 0);
    });

    test("as first code", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, ["6111"]),
          hintsUsed: 0,
          attemptsUsed: 0));
      expect(result, .16);
    });

    test("as second third", () {
      final result = coefficient.calculatePoints(WaypointItemState(
          waypoint: getWaypoint(type),
          items: getItems(type, ["1111"]),
          hintsUsed: 0,
          attemptsUsed: 3));
      expect(result, 1);
    });
  });
}
