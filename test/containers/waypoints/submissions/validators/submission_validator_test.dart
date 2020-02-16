import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/behavior_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/submissions_validator.dart';
import 'package:tgg/containers/waypoints/submissions/validate/validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

main() {
  group("validators", () {
    test("empty text  - should be error", () async {
      final result = validate(BehaviorType.text_answer, null, null);
      expect(result, isNotEmpty);
    });
    test("not empty text  - should  not be error", () async {
      final result = validate(BehaviorType.text_unverified, "value", null);
      expect(result, null);
    });

    test("validate not empty text in list", () async {
      final item = WaypointSubmissionItem(
          id: 1,
          submission: WaypointSubmission.from("text").first,
          answer: "not empty text");
      final result = validateList(BehaviorType.text_answer, [item]);
      expect(result, isNull);
    });
    test("validate empty text in list", () async {
      final item = WaypointSubmissionItem(
        id: 1,
        submission: WaypointSubmission.from("text").first,
        answer: null,
      );
      final separator = ",";
      final result =
          validateList(BehaviorType.text_answer, [item], separator: separator);
      expect(result, [defaultEmptyError].join(separator));
    });
    test("validate empty text in list twice", () async {
      final item = WaypointSubmissionItem(
        id: 1,
        submission: WaypointSubmission.from("text").first,
        answer: null,
      );
      final separator = ",";
      final result = validateList(BehaviorType.text_answer, [item, item],
          separator: separator);
      expect(result, [defaultEmptyError, defaultEmptyError].join(separator));
    });
  });
}
