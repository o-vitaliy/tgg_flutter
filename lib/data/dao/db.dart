import 'dart:io';

import 'package:moor/moor.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:tgg/data/dao/tables.dart';

part 'db.g.dart';

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return VmDatabase(file);
  });
}

@UseMoor(tables: [
  SubmissionsTable,
  SubmissionTable,
  MediaTable,
  HintsTable,
  AnswerTable,
  WaypointTable,
  PointsTable
])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase({QueryExecutor executor}) : super(executor ?? _openConnection());

  // you should bump this number whenever you change or add a table definition.
  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(onCreate: (Migrator m) {
        return m.createAll();
      }, onUpgrade: (Migrator m, int from, int to) async {
        if (from == 2) {
          // added the teamId property in the change from version 2
          await m.addColumn(waypointTable, waypointTable.teamId);
        }
      });

  SimpleSelectStatement<MediaTable, MediaTableData> get selectMediaTable =>
      select(mediaTable);

  InsertStatement<MediaTableData> get intoMediaTable => into(mediaTable);

  UpdateStatement<MediaTable, MediaTableData> get updateMediaTable =>
      update(mediaTable);

  SimpleSelectStatement<SubmissionsTable, SubmissionsTableData>
      get selectSubmissionsTable => select(submissionsTable);

  InsertStatement<SubmissionsTableData> get intoSubmissionsTable =>
      into(submissionsTable);

  UpdateStatement<SubmissionsTable, SubmissionsTableData>
      get updateSubmissionsTable => update(submissionsTable);

  SimpleSelectStatement<HintsTable, HintsTableData> get selectHintsTable =>
      select(hintsTable);

  InsertStatement<HintsTableData> get intoHintsTable => into(hintsTable);

  SimpleSelectStatement<AnswerTable, AnswerTableData> get selectAnswerTable =>
      select(answerTable);

  InsertStatement<AnswerTableData> get intoAnswerTable => into(answerTable);

  Future<QueryRow> getHintsUsed(String waypointId) => customSelectQuery(
      "SELECT COUNT(*) as count FROM hints_table WHERE waypoint_id=?",
      variables: [Variable.withString(waypointId)]).getSingle();

  SimpleSelectStatement<WaypointTable, WaypointTableData>
      get selectWaypointTable => select(waypointTable);

  InsertStatement<WaypointTableData> get intoWaypointTable =>
      into(waypointTable);

  UpdateStatement<WaypointTable, WaypointTableData> get updateWaypointTable =>
      update(waypointTable);

  SimpleSelectStatement<PointsTable, PointsTableData> get selectPointsTable =>
      select(pointsTable);

  InsertStatement<PointsTableData> get intoPointsTable => into(pointsTable);

  DeleteStatement<PointsTable, PointsTableData> get deletePointTable =>
      delete(pointsTable);
}
