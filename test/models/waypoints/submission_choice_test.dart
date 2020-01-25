import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

final _mockedJson =
    """[{"text":"first","value":false},{"text":"second","value":false},{"text":"correct","value":true},{"text":"last","value":false}]""";

List<SubmissionChoice> get mocked {
  final map = json.decode(_mockedJson);
  return SubmissionChoice.from(map);
}

main() {
  group("parse choises", () {
    test("test parsed without crash", () {
      expect(mocked, isNotNull);
    });

    test("check lenght", () {
      expect(mocked.length, 4);
    });
    test("has correct answer", () {
      expect(mocked.any((it) => it.correct), true);
    });

    test("not all answers are correct", () {
      expect(mocked.every((it) => it.correct), false);
    });

    test("corrct answers is third", () {
      expect(mocked.indexWhere((it) => it.correct), 2);
    });
  });
}
