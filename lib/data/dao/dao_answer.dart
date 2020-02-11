import 'package:moor/moor.dart';

import 'db.dart';

class DaoAnswer {
  final AppDatabase _appDatabase;

  DaoAnswer(this._appDatabase);

  Future<int> insert(String waypointId, String submissionType, String answer) {
    return _appDatabase.intoAnswerTable.insert(
        AnswerTableCompanion.insert(
            waypointId: waypointId,
            submissionType: submissionType,
            answer: answer),
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

/*Future<List<Answer>> getAnswers(String waypointId) async {
    final rows = await (_appDatabase.selectAnswerTable
          ..where((a) => a.waypointId.equals(waypointId)))
        .get();

    Set<String> types = Set<String>.from(rows.map((a) => a.submissionType));
    return List.from(
        types.map((t) => Answer(
              t,
              List<String>.from(
                  rows
                      .where((a) => a.submissionType.endsWith(t))
                      .map((a) => a.answer),
                  growable: false),
            )),
        growable: false);
  }*/
}
