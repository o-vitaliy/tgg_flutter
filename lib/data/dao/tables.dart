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
