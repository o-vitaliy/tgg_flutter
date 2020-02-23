import 'package:moor/moor.dart';

import 'db.dart';

class DaoWaypoint {
  final AppDatabase _appDatabase;

  DaoWaypoint(this._appDatabase);

  Future<int> insert(String waypointId, String mode, String waypointJson) {
    return _appDatabase.intoWaypointTable.insert(
        WaypointTableCompanion.insert(
          waypointId: waypointId,
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
