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
    test("movie", () async {
      expect(SubmissionTypeHelper.fromString("movie"), SubmissionType.movie);
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
    test("movie", () async {
      expect(SubmissionTypeHelper.isMediaFromString("movie"), true);
    });
  });

  group("is_media", () {
    test("check dosn't fail check all values", () async {
      SubmissionType.values
          .forEach((type) => SubmissionTypeHelper.isMedia(type));
    });
  });
}
