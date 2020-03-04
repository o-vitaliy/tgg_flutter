import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/containers/waypoints/submissions/answer_transformer.dart';
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

  group("get transform", () {
    test("checks all types are covered ", () {
      SubmissionType.values.forEach((type) {
        final result = SubmissionTypeHelper.getTransformer(type);
        expect(result, isInstanceOf<AnswerTransformer>());
      });
    });

    test("checks", () async {
      expect(SubmissionTypeHelper.getTransformer(SubmissionType.choice),
          isInstanceOf<ListStringTransformer>());
      expect(SubmissionTypeHelper.getTransformer(SubmissionType.checkboxes),
          isInstanceOf<ListStringTransformer>());

      expect(SubmissionTypeHelper.getTransformer(SubmissionType.text),
          isInstanceOf<StringTransformer>());
      expect(SubmissionTypeHelper.getTransformer(SubmissionType.number),
          isInstanceOf<StringTransformer>());
      expect(SubmissionTypeHelper.getTransformer(SubmissionType.photo),
          isInstanceOf<StringTransformer>());
      expect(SubmissionTypeHelper.getTransformer(SubmissionType.movie),
          isInstanceOf<StringTransformer>());
      expect(SubmissionTypeHelper.getTransformer(SubmissionType.camera),
          isInstanceOf<StringTransformer>());

      expect(SubmissionTypeHelper.getTransformer(SubmissionType.yesno),
          isInstanceOf<BooleanTransformer>());
    });
  });
}
