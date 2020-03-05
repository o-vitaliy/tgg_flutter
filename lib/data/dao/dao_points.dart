import 'package:moor/moor.dart';

import 'db.dart';

class DaoPoints {
  final AppDatabase _appDatabase;

  DaoPoints(this._appDatabase);

  Future<int> insert(String waypointId, double points) {
    return _appDatabase.intoPointsTable.insert(
        PointsTableCompanion.insert(waypointId: waypointId, points: points),
        mode: InsertMode.insertOrReplace);
  }

  Future<double> getSum() async {
    final list = await _appDatabase.selectPointsTable.get();
    final points = list.map((e) => e.points);
    final result = points.fold(0.0, (value, element) => value + element);
    return result;
  }

  Future<int> deleteAll() {
    return _appDatabase.deletePointTable.go();
  }
}
