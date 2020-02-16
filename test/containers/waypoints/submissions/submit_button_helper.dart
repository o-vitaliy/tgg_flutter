import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/submit_button_helper.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

main() {
  WaypointSubmissionItem _getItem(bool optional, answer) {
    return WaypointSubmissionItem(
        id: 1,
        submission:
            WaypointSubmission.from({"type": "text", "optional": optional})
                .first,
        answer: answer);
  }

  group("single is enabled", () {
    test("not optional & null value => false", () async {
      final bool result = SubmitButtonHelper().isEnabled(_getItem(false, null));
      expect(result, false);
    });

    test("not optional & empty => false", () async {
      final bool result = SubmitButtonHelper().isEnabled(_getItem(false, ""));
      expect(result, false);
    });

    test("not optional & not empty => true", () async {
      final bool result =
          SubmitButtonHelper().isEnabled(_getItem(false, "same value"));
      expect(result, true);
    });

    test("optional & empty => true", () async {
      final bool result = SubmitButtonHelper().isEnabled(_getItem(true, null));
      expect(result, true);
    });

    test("optional & not empty => true", () async {
      final bool result =
          SubmitButtonHelper().isEnabled(_getItem(true, "same value"));
      expect(result, true);
    });

    test("not optional & not empty list => true", () async {
      final bool result =
          SubmitButtonHelper().isEnabled(_getItem(false, ["1"]));
      expect(result, true);
    });

    test("not optional & empty list => false", () async {
      final bool result = SubmitButtonHelper().isEnabled(_getItem(false, []));
      expect(result, false);
    });
  });

  group("list is enabled", () {
    test("requred+optional  & not empty => true", () async {
      final bool result = SubmitButtonHelper().isEnabledList([
        _getItem(false, "value"),
        _getItem(true, "value"),
      ]);
      expect(result, true);
    });

    test("requred+requred  & not empty => true", () async {
      final bool result = SubmitButtonHelper().isEnabledList([
        _getItem(false, "value"),
        _getItem(false, "value"),
      ]);
      expect(result, true);
    });

    test("requred+optional & empty => false", () async {
      final bool result = SubmitButtonHelper().isEnabledList([
        _getItem(false, ""),
        _getItem(false, ""),
      ]);
      expect(result, false);
    });
  });
}
