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
  });
}
