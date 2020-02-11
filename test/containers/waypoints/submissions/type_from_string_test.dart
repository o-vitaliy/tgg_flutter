import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';

main() {
  group("type_from_string", () {
    test("text", () async {
      expect(SubmissionTypeHelper.fromString("text"), SubmissionType.text);
    });
    test("photo", () async {
      expect(SubmissionTypeHelper.fromString("photo"), SubmissionType.photo);
    });
    test("number", () async {
      expect(SubmissionTypeHelper.fromString("number"), SubmissionType.number);
    });
    test("choice", () async {
      expect(SubmissionTypeHelper.fromString("choice"), SubmissionType.choice);
    });
    test("choice", () async {
      expect(SubmissionTypeHelper.fromString("checkboxes"),
          SubmissionType.checkboxes);
    });
    test("movie", () async {
      expect(SubmissionTypeHelper.fromString("movie"), SubmissionType.movie);
    });
    test("camera", () async {
      expect(SubmissionTypeHelper.fromString("camera"), SubmissionType.camera);
    });
  });

  group("is_media from string", () {
    test("text", () async {
      expect(SubmissionTypeHelper.isMediaFromString("text"), false);
    });
    test("photo", () async {
      expect(SubmissionTypeHelper.isMediaFromString("photo"), true);
    });
    test("number", () async {
      expect(SubmissionTypeHelper.isMediaFromString("number"), false);
    });
    test("choice", () async {
      expect(SubmissionTypeHelper.isMediaFromString("choice"), false);
    });
    test("checkboxes", () async {
      expect(SubmissionTypeHelper.isMediaFromString("checkboxes"), false);
    });
    test("movie", () async {
      expect(SubmissionTypeHelper.isMediaFromString("movie"), true);
    });
    test("camera", () async {
      expect(SubmissionTypeHelper.isMediaFromString("camera"), true);
    });
  });

  group("is_media", () {
    test("checks all types are covered ", () async {
      SubmissionType.values
          .forEach((type) => SubmissionTypeHelper.isMedia(type));
    });
  });

  group("is mutli choice", () {
    test("checks all types are covered ", () async {
      SubmissionType.values
          .forEach((type) => SubmissionTypeHelper.isMedia(type));
    });

    test("checks", () async {
      expect(SubmissionTypeHelper.isMultiChoice(SubmissionType.choice), true);
      expect(
          SubmissionTypeHelper.isMultiChoice(SubmissionType.checkboxes), true);

      expect(SubmissionTypeHelper.isMultiChoice(SubmissionType.text), false);
      expect(SubmissionTypeHelper.isMultiChoice(SubmissionType.number), false);
      expect(SubmissionTypeHelper.isMultiChoice(SubmissionType.photo), false);
      expect(SubmissionTypeHelper.isMultiChoice(SubmissionType.movie), false);
      expect(SubmissionTypeHelper.isMultiChoice(SubmissionType.camera), false);
    });
  });
}
