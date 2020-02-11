import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  AppDatabase database;
  setUpAll(() async {
    database = AppDatabase();
  });
  group("database", () {
    test("dBSubmission not null", () async {
      expect(database.submissionTable, isNotNull);
    });

    test("dBSubmissionItem not null", () async {
      expect(database.submissionsTable, isNotNull);
    });

    test("mediaTable not null", () async {
      expect(database.mediaTable, isNotNull);
    });
    test("hintsTable not null", () async {
      expect(database.hintsTable, isNotNull);
    });
    test("answerTable not null", () async {
      expect(database.answerTable, isNotNull);
    });
  });
}
