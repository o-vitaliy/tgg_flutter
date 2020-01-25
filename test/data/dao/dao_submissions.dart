import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/data/dao/dao_submission.dart';
import 'package:tgg/data/dao/db.dart';

main() {
  DaoSubmission daoSubmission;
  AppDatabase database;
  final waypointId = "waypointId";
  final startedAt = DateTime.utc(2020);
  final lat = 23.12;
  final lng = 12.23;
  setUp(() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = AppDatabase(executor: VmDatabase.memory());
    daoSubmission = DaoSubmission(database);
  });
  tearDown(() async {
    await database.close();
  });
  group("daos", () {
    test("insert", () async {
      int insertId =
          await daoSubmission.insert(waypointId, startedAt, lat, lng);
      expect(insertId, isNotNull);
      expect(insertId, isPositive);
    });

    test("get after insert", () async {
      await daoSubmission.insert(waypointId, startedAt, lat, lng);
      final submissions = await daoSubmission.findById(waypointId);
      expect(submissions.waypointId, waypointId);
      expect(submissions.startedAt.millisecondsSinceEpoch,
          startedAt.millisecondsSinceEpoch);
      expect(submissions.startedLocationLat, lat);
      expect(submissions.startedLocationLng, lng);
    });
  });
}
