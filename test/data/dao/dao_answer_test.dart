import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/data/dao/dao_answer.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  DaoAnswer dao;
  AppDatabase database;
  setUp(() async {
    database = AppDatabase(executor: VmDatabase.memory());
    dao = DaoAnswer(database);
  });
  tearDown(() async {
    await database.close();
  });
  group("dao", () {
    test("insert", () async {
      int insertId = await dao.insert("wp", "type", "a1", DateTime.now());
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });

    test("get empty", () async {
      final result = await dao.getAnswerSubmissionTypes("wp1");
      expect(result, []);
    });
    test("get type", () async {
      await dao.insert("wp2", "type", "a1", DateTime.now());
      await dao.insert("wp2", "type", "a2", DateTime.now());
      expect(await dao.getAnswerSubmissionTypes("wp2"), ["type"]);
      await dao.insert("wp2", "type2", "a2", DateTime.now());
      expect(await dao.getAnswerSubmissionTypes("wp2"), ["type", "type2"]);
    });
    test("get values by type for two types", () async {
      await dao.insert("wp2", "type", "a1", DateTime.now());
      await dao.insert("wp2", "type", "a2", DateTime.now());
      await dao.insert("wp2", "type2", "a1", DateTime.now());
      await dao.insert("wp2", "type2", "a2", DateTime.now());
      expect(await dao.getAnswerByType("wp2", "type"), ["a1", "a2"]);
      expect(await dao.getAnswerByType("wp2", "type2"), ["a1", "a2"]);
    });

    test("get values by waypointId", () async {
      await dao.insert("wp2", "type", "a1", DateTime.now());
      await dao.insert("wp2", "type", "a2", DateTime.now());
      await dao.insert("wp2", "type2", "a1", DateTime.now());
      await dao.insert("wp2", "type2", "a2", DateTime.now());
      expect(await dao.getAnswersByWaypointId("wp2"), ["a1", "a2", "a1", "a2"]);
    });

    test("type is null", () async {
      await dao.insert("wp2", null, null, DateTime.now());
      expect(await dao.getAnswersByWaypointId("wp2"), [null]);
    });

    test("get asnwers by waypointId", () async {
      await dao.insert("wp2", "type", "type_a1", DateTime.now());
      await dao.insert("wp2", "type2", "type2_a1", DateTime.now());
      await dao.insert("wp2", "type", "type_a2", DateTime.now());
      await dao.insert("wp2", "type2", "type2_a2", DateTime.now());

      final answers = await dao.getAnswerList("wp2");

      expect(answers[0].waypointId, "wp2");
      expect(answers[0].submissionType, "type");
      expect(answers[0].answer, "type_a1");

      expect(answers[1].waypointId, "wp2");
      expect(answers[1].submissionType, "type2");
      expect(answers[1].answer, "type2_a1");

      expect(answers[2].waypointId, "wp2");
      expect(answers[2].submissionType, "type");
      expect(answers[2].answer, "type_a2");

      expect(answers[3].waypointId, "wp2");
      expect(answers[3].submissionType, "type2");
      expect(answers[3].answer, "type2_a2");
    });
  });
}
