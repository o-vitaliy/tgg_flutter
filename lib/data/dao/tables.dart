import 'package:moor/moor.dart';

class SubmissionTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get waypointId => text()();

  TextColumn get type => text()();

  TextColumn get result => text()();
}

class SubmissionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get waypointId => text()();

  DateTimeColumn get startedAt => dateTime()();

  RealColumn get startedLocationLat => real()();

  RealColumn get startedLocationLng => real()();

  IntColumn get numHintsUsed => integer().nullable()();

  DateTimeColumn get completedAt => dateTime().nullable()();

  RealColumn get completedLocationLat => real().nullable()();

  RealColumn get completedLocationLng => real().nullable()();
}

class MediaTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get mediaId => text()();

  TextColumn get fileUrl => text()();

  TextColumn get key => text()();

  BoolColumn get uploaded => boolean()();
}

class HintsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get waypointId => text()();

  DateTimeColumn get usedAt => dateTime()();
}

class AnswerTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get waypointId => text()();

  TextColumn get submissionType => text().nullable()();

  TextColumn get answer => text().nullable()();

  DateTimeColumn get addedAt =>
      dateTime().clientDefault(() => DateTime.now())();
}

class WaypointTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get waypointId => text().customConstraint('UNIQUE')();

  TextColumn get mode => text()();

  TextColumn get waypointJson => text()();

  BoolColumn get passed => boolean().withDefault(const Constant(false))();

  BoolColumn get synced => boolean().withDefault(const Constant(false))();
}

class PointsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get waypointId => text().customConstraint('UNIQUE')();

  RealColumn get points => real()();
}
