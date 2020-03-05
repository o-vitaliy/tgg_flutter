import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_calculation.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';

import '../../data/mocks.dart';

main() {
  group("chech hint price", () {
    test("hint price", () {
      final result = WaypointCalculation.hintPrice(getWaypoint("text_answer"));
      expect(result, 12.5);
    });
    test("hint penalty when one hint is used", () {
      final result = WaypointCalculation.hintPenalty(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 1,
          attemptsUsed: 0));
      expect(result, 12.5);
    });
    test("hint penalty when two hint were used", () {
      final result = WaypointCalculation.hintPenalty(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 2,
          attemptsUsed: 0));
      expect(result, 25);
    });
  });

  group("points", () {
    test("full points: attemptsUsed: 1, hints: 0", () {
      final result = WaypointCalculation.points(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 0,
          attemptsUsed: 1));
      expect(result, 50);
    });

    test("one hint was used ", () {
      final result = WaypointCalculation.points(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 1,
          attemptsUsed: 1));
      expect(result, 37.5);
    });

    test("all hints were used ", () {
      final result = WaypointCalculation.points(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 4,
          attemptsUsed: 2));
      expect(result, 0);
    });

    test("on second attempt", () {
      final result = WaypointCalculation.points(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 0,
          attemptsUsed: 2));
      expect(result, 25);
    });

    test("on second attempt having 2", () {
      final result = WaypointCalculation.points(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 0,
          attemptsUsed: 2));
      expect(result, 25);
    });
    test("on third attempt having 2", () {
      final result = WaypointCalculation.points(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 0,
          attemptsUsed: 3));
      expect(result, 0);
    });

    test("on firth attempt having 2", () {
      final result = WaypointCalculation.points(WaypointItemState(
          waypoint: getWaypoint("text_answer"),
          items: getItems("text_answer", ["text"]),
          hintsUsed: 0,
          attemptsUsed: 4));
      expect(result, 0);
    });
  });
}
