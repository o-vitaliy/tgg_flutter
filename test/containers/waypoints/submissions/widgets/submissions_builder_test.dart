import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/widget/submissions_builder.dart';
import 'package:tgg/containers/waypoints/submissions/widget/take_photo_widget.dart';
import 'package:tgg/containers/waypoints/submissions/widget/text_widget.dart';

main() {
  group("submissions_builder_test", () {
    test("text", () async {
      final component = build(SubmissionType.text, null, null, (_) {}, () {});
      expect(component, isInstanceOf<TextWidget>());
    });

    test("photo", () async {
      final component = build(SubmissionType.photo, null, null, (_) {}, () {});
      expect(component, isInstanceOf<TakePhotoWidget>());
    });
  });
}
