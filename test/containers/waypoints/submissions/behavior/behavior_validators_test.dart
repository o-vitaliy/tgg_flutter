import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/behaviors.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/helpers/expandable_list.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

import '../../../../data/mocks.dart';

main() {
  List waypointsMap;
  setUpAll(() {
    waypointsMap = json.decode(mockedActiveWaypoints)
      ..addAll(json.decode(
          File("test/data/mocks/activewaypoints.json").readAsStringSync()));
  });

  Waypoint getWaypoint(final String type) {
    final w = waypointsMap.firstOrNull((w1) {
      try {
        return w1["step"]["behavior"]["id"] == type;
      } catch (e) {
        print(w1);
        return false;
      }
    });
    return Waypoint.fromJsonMap(w);
  }

  List<WaypointSubmissionItem> getItems(final String type, List answers) {
    final w = getWaypoint(type);
    final sTypes = w.step.behavior.submissionType;
    final mapped = sTypes.mapIndex((s, i) {
      return WaypointSubmissionItem(id: i, submission: s, answer: answers[i]);
    }).toList();
    return mapped;
  }

  group("text_answer", () {
    final BaseBehaviorType behavior = TextAnswerBehaviorType();
    final type = "text_answer";
    test("null", () {
      final items = getItems(type, [null]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, null);
    });
    test("empty", () {
      final items = getItems(type, [""]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "");
    });
    test("correct", () {
      final items = getItems(type, ["a"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
  });

  group("number_answer", () {
    final BaseBehaviorType behavior = NumberAnswerBehaviorType();
    final type = "number_answer";
    test("null", () {
      final items = getItems(type, [null]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, null);
    });
    test("empty", () {
      final items = getItems(type, [""]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "");
    });
    test("text", () {
      final items = getItems(type, ["a"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "a");
    });
    test("correct", () {
      final items = getItems(type, ["100"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
  });

  group("multiple_choice", () {
    final BaseBehaviorType behavior = MultipleChoiceBehaviorType();
    final type = "multiple_choice";
    test("null", () {
      final items = getItems(type, [null]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, null);
    });
    test("empty", () {
      final items = getItems(type, [""]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "");
    });
    test("incorrect", () {
      final items = getItems(type, ["incorrect"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "incorrect");
    });
    test("correct", () {
      final items = getItems(type, ["correct answer"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
  });
  group("many_choices", () {
    final BaseBehaviorType behavior = ManyChoicesPointBehaviorType();
    final type = "many_choices";
    test("null", () {
      final items = getItems(type, [null]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, null);
    });
    test("empty", () {
      final items = getItems(type, [
        [""]
      ]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "");
    });
    test("incorrect", () {
      final items = getItems(type, [
        ["incorrect"]
      ]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "incorrect");
    });
    test("correct", () {
      final items = getItems(type, [
        ["correct 1", "correct 2"]
      ]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
  });

  group("code_custom", () {
    final BaseBehaviorType behavior = CodeCustomBehaviorType();
    final type = "code_custom";
    test("null", () {
      final items = getItems(type, [null]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, null);
    });
    test("empty", () {
      final items = getItems(type, [""]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "");
    });
    test("incorrect", () {
      final items = getItems(type, ["incorrect"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "incorrect");
    });
    test("correct 1", () {
      final items = getItems(type, ["1"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
    test("correct 2", () {
      final items = getItems(type, ["2"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
  });
  group("code_standard", () {
    final BaseBehaviorType behavior = CodeStandardBehaviorType();
    final type = "code_standard";
    test("null", () {
      final items = getItems(type, [null]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, null);
    });
    test("empty", () {
      final items = getItems(type, [""]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "");
    });
    test("incorrect", () {
      final items = getItems(type, ["incorrect"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "incorrect");
    });
    test("correct 1", () {
      final items = getItems(type, ["6111"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
    test("correct 2", () {
      final items = getItems(type, ["2111"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
  });

  group("plant_score_highest", () {
    final BaseBehaviorType behavior = PlantScoreHighestBehaviorType();
    final type = "plant_score_highest";
    test("null", () {
      final items = getItems(type, [null, null]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, null);
    });
    test("empty", () {
      final items = getItems(type, ["", ""]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "");
    });
    test("incorrect", () {
      final items = getItems(type, ["1", "incorrect"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, false);
      expect(validationResult.incorrectAnswer, "incorrect");
    });
    test("correct", () {
      final items = getItems(type, ["1", "1111"]);
      final validationResult = behavior.isValid(items);
      expect(validationResult.isValid, true);
    });
  });
}
