import 'package:moor/moor.dart';

import 'db.dart';

class DaoWaypoint {
  final AppDatabase _appDatabase;

  DaoWaypoint(this._appDatabase);

  Future<int> insert(
      String waypointId, String teamId, String mode, String waypointJson) {
    return _appDatabase.intoWaypointTable.insert(
        WaypointTableCompanion.insert(
          waypointId: waypointId,
          teamId: Value(teamId),
          mode: mode,
          waypointJson: waypointJson,
        ),
        mode: InsertMode.insertOrIgnore);
  }

  Future<WaypointTableData> getWaypoint(String waypointId) {
    return (_appDatabase.selectWaypointTable
          ..where((a) => a.waypointId.equals(waypointId)))
        .getSingle();
  }

  Future<Iterable<String>> getActive(String teamId) async {
    final Iterable<WaypointTableData> list =
        await (_appDatabase.selectWaypointTable
              ..where((a) => a.teamId.equals(teamId))
              ..where((a) => a.passed.equals(false)))
            .get();

    return list.map((e) => e.waypointJson);
  }

  Future<Iterable<String>> getNotSynced(String teamId) async {
    final Iterable<WaypointTableData> list =
        await (_appDatabase.selectWaypointTable
              ..where((a) => a.teamId.equals(teamId))
              ..where((a) => a.passed.equals(true))
              ..where((a) => a.synced.equals(false)))
            .get();

    return list.map((e) => e.waypointJson);
  }

  Future savePassed(String waypointId) async {
    return (_appDatabase.updateWaypointTable
          ..where((t) => t.waypointId.equals(waypointId)))
        .write(WaypointTableCompanion(passed: Value(true)));
  }

  Future saveSynced(String waypointId) async {
    return (_appDatabase.updateWaypointTable
          ..where((t) => t.waypointId.equals(waypointId)))
        .write(WaypointTableCompanion(synced: Value(true)));
  }
}
