import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/data/dao/dao_hints.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  DaoHint dao;
  AppDatabase database;
  setUp(() async {
    database = AppDatabase(executor: VmDatabase.memory());
    dao = DaoHint(database);
  });
  tearDown(() async {
    await database.close();
  });
  group("dao", () {
    test("insert", () async {
      int insertId = await dao.insert("wp");
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });

    test("get count 0", () async {
      final result = await dao.getUsedHints("wp1");
      expect(result, 0);
    });

    test("get count after insert", () async {
      await dao.insert("wp2");
      expect(await dao.getUsedHints("wp2"), 1);
      await dao.insert("wp2");
      expect(await dao.getUsedHints("wp2"), 2);
    });
  });
}
