import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  DaoMedia dao;
  AppDatabase database;
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = AppDatabase(executor: VmDatabase.memory());
    dao = DaoMedia(database);
  });
  tearDown(() async {
    await database.close();
  });
  group("daos", () {
    test("insert", () async {
      int insertId = await dao.insert("media", "path", "key");
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });

    test("get by path", () async {
      await dao.insert("mediaId", "path", "key");
      final mediaTableData = await dao.findByUrl("path");
      expect(mediaTableData.mediaId, "mediaId");
      expect(mediaTableData.fileUrl, "path");
      expect(mediaTableData.uploaded, false);
    });

    test("get by key", () async {
      await dao.insert("mediaId", "path", "key");
      final mediaTableData = await dao.findByKey("key");
      expect(mediaTableData.mediaId, "mediaId");
      expect(mediaTableData.fileUrl, "path");
      expect(mediaTableData.uploaded, false);
    });

    test("get after updateUploaded", () async {
      await dao.insert("mediaId", "path", "key");
      expect((await dao.findByUrl("path")).uploaded, false);
      await dao.updateUploadedByUrl("path", true);
      expect((await dao.findByUrl("path")).uploaded, true);
    });
  });
}
