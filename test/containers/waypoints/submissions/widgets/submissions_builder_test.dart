import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/widget/camera_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/checkbox_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/radio_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/submissions_builder.dart';
import 'package:tgg/containers/waypoints/submissions/widget/take_photo_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/take_video_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/text_widget.dart';

main() {
  group("submissions_builder_test", () {
    test("check if all types are covered", () {
      SubmissionType.values.forEach((type) {
        final component = build(type, (_) {}, (_) {});
        expect(component, isNotNull);
      });
    });
    test("text", () async {
      final component = build(SubmissionType.text, (_) {}, (_) {});
      expect(component, isInstanceOf<TextWidget>());
    });

    test("photo", () async {
      final component = build(SubmissionType.photo, (_) {}, (_) {});
      expect(component, isInstanceOf<TakePhotoWidget>());
    });

    test("choice", () async {
      final component = build(SubmissionType.choice, (_) {}, (_) {});
      expect(component, isInstanceOf<RadioWidget>());
    });
    test("movie", () async {
      final component = build(SubmissionType.movie, (_) {}, (_) {});
      expect(component, isInstanceOf<TakeVideoWidget>());
    });
    test("checkboxes", () async {
      final component = build(SubmissionType.checkboxes, (_) {}, (_) {});
      expect(component, isInstanceOf<CheckboxWidget>());
    });
    test("camera", () async {
      final component = build(SubmissionType.camera, (_) {}, (_) {});
      expect(component, isInstanceOf<CameraWidget>());
    });
  });
}
