import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

final _mockedJson =
    """[{"text":"first","value":true},{"text":"second","value":false},{"text":"correct","value":true},{"text":"last","value":false}]""";

List<SubmissionChoice> get mockedChoices {
  final map = json.decode(_mockedJson);
  return SubmissionChoice.from(map);
}

main() {
  group("parse choises", () {
    test("test parsed without crash", () {
      expect(mockedChoices, isNotNull);
    });

    test("check lenght", () {
      expect(mockedChoices.length, 4);
    });
    test("has correct answer", () {
      expect(mockedChoices.any((it) => it.correct), true);
    });

    test("not all answers are correct", () {
      expect(mockedChoices.every((it) => it.correct), false);
    });

    test("corrct answers is third", () {
      expect(mockedChoices.indexWhere((it) => it.correct), 0);
    });
  });
}
