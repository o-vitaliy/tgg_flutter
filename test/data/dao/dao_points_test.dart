import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/data/dao/dao_points.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  DaoPoints dao;
  AppDatabase database;
  setUp(() async {
    database = AppDatabase(executor: VmDatabase.memory());
    dao = DaoPoints(database);
  });
  tearDown(() async {
    await database.close();
  });
  group("insert", () {
    test("insert", () async {
      int insertId = await dao.insert("wp", 1.2);
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });
    test("insert2 ", () async {
      final insertId = await dao.insert("wp", 0.1);
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });
  });

  group("get sum", () {
    test("sum for empty", () async {
      expect(await dao.getSum(), 0);
    });
    test("sum 1", () async {
      await dao.insert("wp", 1.2);
      expect(await dao.getSum(), 1.2);
    });
    test("sum 2", () async {
      await dao.insert("wp", 1.2);
      await dao.insert("wp2", 1.2);
      expect(await dao.getSum(), 2.4);
    });
    test("sum 3", () async {
      await dao.insert("wp1", 0.0);
      await dao.insert("wp2", -1);
      await dao.insert("wp3", 2);
      expect(await dao.getSum(), 1);
    });
  });

  group("delete", () {
    test("empty", () async {
      expect(await dao.deleteAll(), 0);
      expect(await dao.getSum(), 0);
    });
    test("1 element ", () async {
      await dao.insert("wp", 1.2);
      expect(await dao.deleteAll(), 1);
      expect(await dao.getSum(), 0);
    });
    test("2 elements", () async {
      await dao.insert("wp", 1.2);
      await dao.insert("wp2", 1.2);
      expect(await dao.deleteAll(), 2);
      expect(await dao.getSum(), 0);
    });
  });
}
