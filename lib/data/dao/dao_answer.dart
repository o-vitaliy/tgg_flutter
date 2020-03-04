import 'package:moor/moor.dart';

import 'db.dart';

class DaoAnswer {
  final AppDatabase _appDatabase;

  DaoAnswer(this._appDatabase);

  Future<int> insert(String waypointId, String submissionType, String answer,
      DateTime addedAt) {
    return _appDatabase.intoAnswerTable.insert(
        AnswerTableCompanion.insert(
            waypointId: waypointId,
            submissionType:
                submissionType != null ? Value(submissionType) : Value.absent(),
            answer: answer != null ? Value(answer) : Value.absent(),
            addedAt: addedAt),
        mode: InsertMode.insertOrAbort);
  }

  Future<Iterable<String>> getAnswerSubmissionTypes(String waypointId) async {
    final query = await (_appDatabase.selectAnswerTable
          ..where((a) => a.waypointId.equals(waypointId)))
        .get();

    return query.map((a) => a.submissionType).toSet();
  }

  Future<List<String>> getAnswerByType(
      String waypointId, String submissionType) async {
    final query = await (_appDatabase.selectAnswerTable
          ..where((a) => a.waypointId.equals(waypointId))
          ..where((a) => a.submissionType.equals(submissionType)))
        .get();

    return query.map((a) => a.answer).toList(growable: false);
  }

  Future<List<String>> getAnswersByWaypointId(String waypointId) async {
    final query = await (_appDatabase.selectAnswerTable
          ..where((a) => a.waypointId.equals(waypointId)))
        .get();

    return query.map((a) => a.answer).toList(growable: false);
  }

  Future<List<AnswerTableData>> getAnswerList(String waypointId) async {
    final rows = await (_appDatabase.selectAnswerTable
          ..where((a) => a.waypointId.equals(waypointId)))
        .get();

    return rows;
  }
}
