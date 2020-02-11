import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/data/dao/dao_waypoints.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  final waypointId = "waypontId";
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
      int insertId = await dao.insert(waypointId, waypontJson);
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });

    test("get json", () async {
      await dao.insert(waypointId, waypontJson);
      final result = await dao.getWaypoint(waypointId);
      expect(result.waypointJson, waypontJson);
    });

    test("update passed", () async {
      await dao.insert(waypointId, waypontJson);
      expect((await dao.getWaypoint(waypointId)).passed, false);
      await dao.savePassed(waypointId);
      expect((await dao.getWaypoint(waypointId)).passed, true);
    });

    test("update synced", () async {
      await dao.insert(waypointId, waypontJson);
      expect((await dao.getWaypoint(waypointId)).synced, false);
      await dao.saveSynced(waypointId);
      expect((await dao.getWaypoint(waypointId)).synced, true);
    });
  });
}
