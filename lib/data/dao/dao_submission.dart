import 'package:moor/moor.dart';

import 'db.dart';

class DaoSubmission {
  final AppDatabase _appDatabase;

  DaoSubmission(this._appDatabase);

  Future<int> insert(
      String waypointId, DateTime startedAt, double lat, double lng) {
    return _appDatabase.into(_appDatabase.submissionsTable).insert(
        SubmissionsTableCompanion.insert(
            waypointId: waypointId,
            startedAt: startedAt,
            startedLocationLat: lat,
            startedLocationLng: lng,
          ),
        mode: InsertMode.insertOrAbort);
  }

  Future<SubmissionsTableData> findById(String waypointId) {
    return (_appDatabase.select(_appDatabase.submissionsTable)
          ..where((t) => t.waypointId.equals(waypointId)))
        .getSingle();
  }
}
