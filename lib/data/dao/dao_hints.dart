import 'package:moor/moor.dart';

import 'db.dart';

class DaoHint {
  final AppDatabase _appDatabase;

  DaoHint(this._appDatabase);

  Future<int> insert(String waypointId) {
    return _appDatabase.intoHintsTable.insert(
        HintsTableCompanion.insert(
            waypointId: waypointId, usedAt: DateTime.now()),
        mode: InsertMode.insertOrAbort);
  }

  Future<int> getUsedHints(String waypointId) async {
    final row = await _appDatabase.getHintsUsed(waypointId);
    return row.readInt("count");
  }
}
