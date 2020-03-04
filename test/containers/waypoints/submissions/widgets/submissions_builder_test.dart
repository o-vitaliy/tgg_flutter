import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/widget/camera_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/checkbox_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/radio_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/redirect_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/submissions_builder.dart';
import 'package:tgg/containers/waypoints/submissions/widget/take_photo_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/take_video_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/text_widget.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

main() {
  Widget buildComponent(SubmissionType type) {
    final t = type.toString().split(".")[1];
    return build(
        WaypointSubmissionItem.initial(0, WaypointSubmission.from(t).first),
        (_) {},
        () {});
  }

  group("submissions_builder_test", () {
    test("check if all types are covered", () {
      SubmissionType.values.forEach((type) {
        final component = buildComponent(type);
        expect(component, isNotNull);
      });
    });
    test("text", () async {
      final component = buildComponent(SubmissionType.text);
      expect(component, isInstanceOf<TextWidget>());
    });

    test("photo", () async {
      final component = buildComponent(SubmissionType.photo);
      expect(component, isInstanceOf<TakePhotoWidget>());
    });

    test("choice", () async {
      final component = buildComponent(SubmissionType.choice);
      expect(component, isInstanceOf<RadioWidget>());
    });
    test("movie", () async {
      final component = buildComponent(SubmissionType.movie);
      expect(component, isInstanceOf<TakeVideoWidget>());
    });
    test("checkboxes", () async {
      final component = buildComponent(SubmissionType.checkboxes);
      expect(component, isInstanceOf<CheckboxWidget>());
    });
    test("camera", () async {
      final component = buildComponent(SubmissionType.camera);
      expect(component, isInstanceOf<CameraWidget>());
    });
    test("redirect", () async {
      final component = buildComponent(SubmissionType.redirect);
      expect(component, isInstanceOf<RedirectWidget>());
    });
  });
}
