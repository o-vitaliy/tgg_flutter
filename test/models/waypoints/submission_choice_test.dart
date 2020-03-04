import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';

final _mockedJson =
    """[{"text":"first","value":true},{"text":"second","value":false},{"text":"correct","value":true},{"text":"last","value":false}]""";
final _mockedYesnoJson =
    """[{"text":"We won!","value":true},{"text":"We lost","value":false}]""";

List<SubmissionChoice> get mockedChoices {
  final map = json.decode(_mockedJson);
  return SubmissionChoice.from(map);
}

List<SubmissionChoice> get mockedYesNo {
  final map = json.decode(_mockedYesnoJson);
  return SubmissionChoice.from(map);
}

main() {
  group("parse choises", () {
    test("test parsed without crash", () {
      expect(mockedChoices, isNotNull);
    });
    test("test parsed yesno without crash", () {
      expect(mockedYesNo, isNotNull);
      expect(mockedYesNo.length, 2);
      expect(mockedYesNo[0].text, "We won!");
      expect(mockedYesNo[0].value, true);
    });

    test("check length", () {
      expect(mockedChoices.length, 4);
    });
    test("has correct answer", () {
      expect(mockedChoices.any((it) => it.value), true);
    });

    test("not all answers are correct", () {
      expect(mockedChoices.every((it) => it.value), false);
    });

    test("corrct answers is third", () {
      expect(mockedChoices.indexWhere((it) => it.value), 0);
    });
  });
}
