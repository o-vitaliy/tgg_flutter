import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/data/dao/dao_waypoints.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  final waypointId = "waypontId";
  final waypointMode = "main";
  final waypontJson = "{waypontId:waypontJson}";

  DaoWaypoint dao;
  AppDatabase database;
  setUp(() async {
    database = AppDatabase(executor: VmDatabase.memory());
    dao = DaoWaypoint(database);
  });
  tearDown(() async {
    await database.close();
  });
  group("dao", () {
    test("insert", () async {
      int insertId = await dao.insert(waypointId, waypointMode, waypontJson);
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });

    test("get json", () async {
      await dao.insert(waypointId, waypointMode, waypontJson);
      final result = await dao.getWaypoint(waypointId);
      expect(result.waypointJson, waypontJson);
    });

    test("update passed", () async {
      await dao.insert(waypointId, waypointMode, waypontJson);
      expect((await dao.getWaypoint(waypointId)).passed, false);
      await dao.savePassed(waypointId);
      expect((await dao.getWaypoint(waypointId)).passed, true);
    });

    test("update synced", () async {
      await dao.insert(waypointId, waypointMode, waypontJson);
      expect((await dao.getWaypoint(waypointId)).synced, false);
      await dao.saveSynced(waypointId);
      expect((await dao.getWaypoint(waypointId)).synced, true);
    });

    test("get active", () async {
      final json1 = waypontJson;
      final json2 = waypontJson + "2";
      final jsonPassed1 = waypontJson + "passed2";
      final jsonPassed2 = waypontJson + "passed2";

      await dao.insert("json1", waypointMode, json1);
      await dao.insert("json2", waypointMode, json2);
      await dao.insert("jsonPassed1", waypointMode, jsonPassed1);
      await dao.insert("jsonPassed2", waypointMode, jsonPassed2);

      await dao.savePassed("jsonPassed1");
      await dao.savePassed("jsonPassed2");

      final result = await dao.getActive();
      expect(result.first, json1);
      expect(result.last, json2);
    });

    test("get not synced", () async {
      final json1 = waypontJson;
      final json2 = waypontJson + "2";
      final jsonPassed1 = waypontJson + "passed2";
      final jsonPassed2 = waypontJson + "passed2";

      await dao.insert("json1", waypointMode, json1);
      await dao.insert("json2", waypointMode, json2);
      await dao.insert("jsonPassed1", waypointMode, jsonPassed1);
      await dao.insert("jsonPassed2", waypointMode, jsonPassed2);

      await dao.savePassed("jsonPassed1");
      await dao.saveSynced("jsonPassed1");

      await dao.savePassed("jsonPassed2");

      final result = await dao.getNotSynced();
      expect(result.length, 1);
      expect(result.first, jsonPassed2);
    });
  });
}
