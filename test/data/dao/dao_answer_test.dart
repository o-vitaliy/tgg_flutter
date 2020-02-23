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
      int insertId = await dao.insert("wp", "type", "a1");
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });

    test("get empty", () async {
      final result = await dao.getAnswerSubmissionTypes("wp1");
      expect(result, []);
    });
    test("get type", () async {
      await dao.insert("wp2", "type", "a1");
      await dao.insert("wp2", "type", "a2");
      expect(await dao.getAnswerSubmissionTypes("wp2"), ["type"]);
      await dao.insert("wp2", "type2", "a2");
      expect(await dao.getAnswerSubmissionTypes("wp2"), ["type", "type2"]);
    });
    test("get values by type for two types", () async {
      await dao.insert("wp2", "type", "a1");
      await dao.insert("wp2", "type", "a2");
      await dao.insert("wp2", "type2", "a1");
      await dao.insert("wp2", "type2", "a2");
      expect(await dao.getAnswerByType("wp2", "type"), ["a1", "a2"]);
      expect(await dao.getAnswerByType("wp2", "type2"), ["a1", "a2"]);
    });

    test("get values by waypointId", () async {
      await dao.insert("wp2", "type", "a1");
      await dao.insert("wp2", "type", "a2");
      await dao.insert("wp2", "type2", "a1");
      await dao.insert("wp2", "type2", "a2");
      expect(await dao.getAnswersByWaypointId("wp2"), ["a1", "a2", "a1", "a2"]);
    });
    
    test("type is null", () async {
      await dao.insert("wp2", null, null);
      expect(await dao.getAnswersByWaypointId("wp2"), [null]);
    });
  });
}
