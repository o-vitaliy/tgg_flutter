// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class SubmissionsTableData extends DataClass
    implements Insertable<SubmissionsTableData> {
  final int id;
  final String waypointId;
  final DateTime startedAt;
  final double startedLocationLat;
  final double startedLocationLng;
  final int numHintsUsed;
  final DateTime completedAt;
  final double completedLocationLat;
  final double completedLocationLng;
  SubmissionsTableData(
      {@required this.id,
      @required this.waypointId,
      @required this.startedAt,
      @required this.startedLocationLat,
      @required this.startedLocationLng,
      this.numHintsUsed,
      this.completedAt,
      this.completedLocationLat,
      this.completedLocationLng});
  factory SubmissionsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final doubleType = db.typeSystem.forDartType<double>();
    return SubmissionsTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      waypointId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}waypoint_id']),
      startedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}started_at']),
      startedLocationLat: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}started_location_lat']),
      startedLocationLng: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}started_location_lng']),
      numHintsUsed: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}num_hints_used']),
      completedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}completed_at']),
      completedLocationLat: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}completed_location_lat']),
      completedLocationLng: doubleType.mapFromDatabaseResponse(
          data['${effectivePrefix}completed_location_lng']),
    );
  }
  factory SubmissionsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return SubmissionsTableData(
      id: serializer.fromJson<int>(json['id']),
      waypointId: serializer.fromJson<String>(json['waypointId']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      startedLocationLat:
          serializer.fromJson<double>(json['startedLocationLat']),
      startedLocationLng:
          serializer.fromJson<double>(json['startedLocationLng']),
      numHintsUsed: serializer.fromJson<int>(json['numHintsUsed']),
      completedAt: serializer.fromJson<DateTime>(json['completedAt']),
      completedLocationLat:
          serializer.fromJson<double>(json['completedLocationLat']),
      completedLocationLng:
          serializer.fromJson<double>(json['completedLocationLng']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'waypointId': serializer.toJson<String>(waypointId),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'startedLocationLat': serializer.toJson<double>(startedLocationLat),
      'startedLocationLng': serializer.toJson<double>(startedLocationLng),
      'numHintsUsed': serializer.toJson<int>(numHintsUsed),
      'completedAt': serializer.toJson<DateTime>(completedAt),
      'completedLocationLat': serializer.toJson<double>(completedLocationLat),
      'completedLocationLng': serializer.toJson<double>(completedLocationLng),
    };
  }

  @override
  SubmissionsTableCompanion createCompanion(bool nullToAbsent) {
    return SubmissionsTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      waypointId: waypointId == null && nullToAbsent
          ? const Value.absent()
          : Value(waypointId),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      startedLocationLat: startedLocationLat == null && nullToAbsent
          ? const Value.absent()
          : Value(startedLocationLat),
      startedLocationLng: startedLocationLng == null && nullToAbsent
          ? const Value.absent()
          : Value(startedLocationLng),
      numHintsUsed: numHintsUsed == null && nullToAbsent
          ? const Value.absent()
          : Value(numHintsUsed),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      completedLocationLat: completedLocationLat == null && nullToAbsent
          ? const Value.absent()
          : Value(completedLocationLat),
      completedLocationLng: completedLocationLng == null && nullToAbsent
          ? const Value.absent()
          : Value(completedLocationLng),
    );
  }

  SubmissionsTableData copyWith(
          {int id,
          String waypointId,
          DateTime startedAt,
          double startedLocationLat,
          double startedLocationLng,
          int numHintsUsed,
          DateTime completedAt,
          double completedLocationLat,
          double completedLocationLng}) =>
      SubmissionsTableData(
        id: id ?? this.id,
        waypointId: waypointId ?? this.waypointId,
        startedAt: startedAt ?? this.startedAt,
        startedLocationLat: startedLocationLat ?? this.startedLocationLat,
        startedLocationLng: startedLocationLng ?? this.startedLocationLng,
        numHintsUsed: numHintsUsed ?? this.numHintsUsed,
        completedAt: completedAt ?? this.completedAt,
        completedLocationLat: completedLocationLat ?? this.completedLocationLat,
        completedLocationLng: completedLocationLng ?? this.completedLocationLng,
      );
  @override
  String toString() {
    return (StringBuffer('SubmissionsTableData(')
          ..write('id: $id, ')
          ..write('waypointId: $waypointId, ')
          ..write('startedAt: $startedAt, ')
          ..write('startedLocationLat: $startedLocationLat, ')
          ..write('startedLocationLng: $startedLocationLng, ')
          ..write('numHintsUsed: $numHintsUsed, ')
          ..write('completedAt: $completedAt, ')
          ..write('completedLocationLat: $completedLocationLat, ')
          ..write('completedLocationLng: $completedLocationLng')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          waypointId.hashCode,
          $mrjc(
              startedAt.hashCode,
              $mrjc(
                  startedLocationLat.hashCode,
                  $mrjc(
                      startedLocationLng.hashCode,
                      $mrjc(
                          numHintsUsed.hashCode,
                          $mrjc(
                              completedAt.hashCode,
                              $mrjc(completedLocationLat.hashCode,
                                  completedLocationLng.hashCode)))))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SubmissionsTableData &&
          other.id == this.id &&
          other.waypointId == this.waypointId &&
          other.startedAt == this.startedAt &&
          other.startedLocationLat == this.startedLocationLat &&
          other.startedLocationLng == this.startedLocationLng &&
          other.numHintsUsed == this.numHintsUsed &&
          other.completedAt == this.completedAt &&
          other.completedLocationLat == this.completedLocationLat &&
          other.completedLocationLng == this.completedLocationLng);
}

class SubmissionsTableCompanion extends UpdateCompanion<SubmissionsTableData> {
  final Value<int> id;
  final Value<String> waypointId;
  final Value<DateTime> startedAt;
  final Value<double> startedLocationLat;
  final Value<double> startedLocationLng;
  final Value<int> numHintsUsed;
  final Value<DateTime> completedAt;
  final Value<double> completedLocationLat;
  final Value<double> completedLocationLng;
  const SubmissionsTableCompanion({
    this.id = const Value.absent(),
    this.waypointId = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.startedLocationLat = const Value.absent(),
    this.startedLocationLng = const Value.absent(),
    this.numHintsUsed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.completedLocationLat = const Value.absent(),
    this.completedLocationLng = const Value.absent(),
  });
  SubmissionsTableCompanion.insert({
    this.id = const Value.absent(),
    @required String waypointId,
    @required DateTime startedAt,
    @required double startedLocationLat,
    @required double startedLocationLng,
    this.numHintsUsed = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.completedLocationLat = const Value.absent(),
    this.completedLocationLng = const Value.absent(),
  })  : waypointId = Value(waypointId),
        startedAt = Value(startedAt),
        startedLocationLat = Value(startedLocationLat),
        startedLocationLng = Value(startedLocationLng);
  SubmissionsTableCompanion copyWith(
      {Value<int> id,
      Value<String> waypointId,
      Value<DateTime> startedAt,
      Value<double> startedLocationLat,
      Value<double> startedLocationLng,
      Value<int> numHintsUsed,
      Value<DateTime> completedAt,
      Value<double> completedLocationLat,
      Value<double> completedLocationLng}) {
    return SubmissionsTableCompanion(
      id: id ?? this.id,
      waypointId: waypointId ?? this.waypointId,
      startedAt: startedAt ?? this.startedAt,
      startedLocationLat: startedLocationLat ?? this.startedLocationLat,
      startedLocationLng: startedLocationLng ?? this.startedLocationLng,
      numHintsUsed: numHintsUsed ?? this.numHintsUsed,
      completedAt: completedAt ?? this.completedAt,
      completedLocationLat: completedLocationLat ?? this.completedLocationLat,
      completedLocationLng: completedLocationLng ?? this.completedLocationLng,
    );
  }
}

class $SubmissionsTableTable extends SubmissionsTable
    with TableInfo<$SubmissionsTableTable, SubmissionsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubmissionsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _waypointIdMeta = const VerificationMeta('waypointId');
  GeneratedTextColumn _waypointId;
  @override
  GeneratedTextColumn get waypointId => _waypointId ??= _constructWaypointId();
  GeneratedTextColumn _constructWaypointId() {
    return GeneratedTextColumn(
      'waypoint_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _startedAtMeta = const VerificationMeta('startedAt');
  GeneratedDateTimeColumn _startedAt;
  @override
  GeneratedDateTimeColumn get startedAt => _startedAt ??= _constructStartedAt();
  GeneratedDateTimeColumn _constructStartedAt() {
    return GeneratedDateTimeColumn(
      'started_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _startedLocationLatMeta =
      const VerificationMeta('startedLocationLat');
  GeneratedRealColumn _startedLocationLat;
  @override
  GeneratedRealColumn get startedLocationLat =>
      _startedLocationLat ??= _constructStartedLocationLat();
  GeneratedRealColumn _constructStartedLocationLat() {
    return GeneratedRealColumn(
      'started_location_lat',
      $tableName,
      false,
    );
  }

  final VerificationMeta _startedLocationLngMeta =
      const VerificationMeta('startedLocationLng');
  GeneratedRealColumn _startedLocationLng;
  @override
  GeneratedRealColumn get startedLocationLng =>
      _startedLocationLng ??= _constructStartedLocationLng();
  GeneratedRealColumn _constructStartedLocationLng() {
    return GeneratedRealColumn(
      'started_location_lng',
      $tableName,
      false,
    );
  }

  final VerificationMeta _numHintsUsedMeta =
      const VerificationMeta('numHintsUsed');
  GeneratedIntColumn _numHintsUsed;
  @override
  GeneratedIntColumn get numHintsUsed =>
      _numHintsUsed ??= _constructNumHintsUsed();
  GeneratedIntColumn _constructNumHintsUsed() {
    return GeneratedIntColumn(
      'num_hints_used',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  GeneratedDateTimeColumn _completedAt;
  @override
  GeneratedDateTimeColumn get completedAt =>
      _completedAt ??= _constructCompletedAt();
  GeneratedDateTimeColumn _constructCompletedAt() {
    return GeneratedDateTimeColumn(
      'completed_at',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedLocationLatMeta =
      const VerificationMeta('completedLocationLat');
  GeneratedRealColumn _completedLocationLat;
  @override
  GeneratedRealColumn get completedLocationLat =>
      _completedLocationLat ??= _constructCompletedLocationLat();
  GeneratedRealColumn _constructCompletedLocationLat() {
    return GeneratedRealColumn(
      'completed_location_lat',
      $tableName,
      true,
    );
  }

  final VerificationMeta _completedLocationLngMeta =
      const VerificationMeta('completedLocationLng');
  GeneratedRealColumn _completedLocationLng;
  @override
  GeneratedRealColumn get completedLocationLng =>
      _completedLocationLng ??= _constructCompletedLocationLng();
  GeneratedRealColumn _constructCompletedLocationLng() {
    return GeneratedRealColumn(
      'completed_location_lng',
      $tableName,
      true,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [
        id,
        waypointId,
        startedAt,
        startedLocationLat,
        startedLocationLng,
        numHintsUsed,
        completedAt,
        completedLocationLat,
        completedLocationLng
      ];
  @override
  $SubmissionsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'submissions_table';
  @override
  final String actualTableName = 'submissions_table';
  @override
  VerificationContext validateIntegrity(SubmissionsTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.waypointId.present) {
      context.handle(_waypointIdMeta,
          waypointId.isAcceptableValue(d.waypointId.value, _waypointIdMeta));
    } else if (waypointId.isRequired && isInserting) {
      context.missing(_waypointIdMeta);
    }
    if (d.startedAt.present) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableValue(d.startedAt.value, _startedAtMeta));
    } else if (startedAt.isRequired && isInserting) {
      context.missing(_startedAtMeta);
    }
    if (d.startedLocationLat.present) {
      context.handle(
          _startedLocationLatMeta,
          startedLocationLat.isAcceptableValue(
              d.startedLocationLat.value, _startedLocationLatMeta));
    } else if (startedLocationLat.isRequired && isInserting) {
      context.missing(_startedLocationLatMeta);
    }
    if (d.startedLocationLng.present) {
      context.handle(
          _startedLocationLngMeta,
          startedLocationLng.isAcceptableValue(
              d.startedLocationLng.value, _startedLocationLngMeta));
    } else if (startedLocationLng.isRequired && isInserting) {
      context.missing(_startedLocationLngMeta);
    }
    if (d.numHintsUsed.present) {
      context.handle(
          _numHintsUsedMeta,
          numHintsUsed.isAcceptableValue(
              d.numHintsUsed.value, _numHintsUsedMeta));
    } else if (numHintsUsed.isRequired && isInserting) {
      context.missing(_numHintsUsedMeta);
    }
    if (d.completedAt.present) {
      context.handle(_completedAtMeta,
          completedAt.isAcceptableValue(d.completedAt.value, _completedAtMeta));
    } else if (completedAt.isRequired && isInserting) {
      context.missing(_completedAtMeta);
    }
    if (d.completedLocationLat.present) {
      context.handle(
          _completedLocationLatMeta,
          completedLocationLat.isAcceptableValue(
              d.completedLocationLat.value, _completedLocationLatMeta));
    } else if (completedLocationLat.isRequired && isInserting) {
      context.missing(_completedLocationLatMeta);
    }
    if (d.completedLocationLng.present) {
      context.handle(
          _completedLocationLngMeta,
          completedLocationLng.isAcceptableValue(
              d.completedLocationLng.value, _completedLocationLngMeta));
    } else if (completedLocationLng.isRequired && isInserting) {
      context.missing(_completedLocationLngMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubmissionsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SubmissionsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SubmissionsTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.waypointId.present) {
      map['waypoint_id'] = Variable<String, StringType>(d.waypointId.value);
    }
    if (d.startedAt.present) {
      map['started_at'] = Variable<DateTime, DateTimeType>(d.startedAt.value);
    }
    if (d.startedLocationLat.present) {
      map['started_location_lat'] =
          Variable<double, RealType>(d.startedLocationLat.value);
    }
    if (d.startedLocationLng.present) {
      map['started_location_lng'] =
          Variable<double, RealType>(d.startedLocationLng.value);
    }
    if (d.numHintsUsed.present) {
      map['num_hints_used'] = Variable<int, IntType>(d.numHintsUsed.value);
    }
    if (d.completedAt.present) {
      map['completed_at'] =
          Variable<DateTime, DateTimeType>(d.completedAt.value);
    }
    if (d.completedLocationLat.present) {
      map['completed_location_lat'] =
          Variable<double, RealType>(d.completedLocationLat.value);
    }
    if (d.completedLocationLng.present) {
      map['completed_location_lng'] =
          Variable<double, RealType>(d.completedLocationLng.value);
    }
    return map;
  }

  @override
  $SubmissionsTableTable createAlias(String alias) {
    return $SubmissionsTableTable(_db, alias);
  }
}

class SubmissionTableData extends DataClass
    implements Insertable<SubmissionTableData> {
  final int id;
  final String waypointId;
  final String type;
  final String result;
  SubmissionTableData(
      {@required this.id,
      @required this.waypointId,
      @required this.type,
      @required this.result});
  factory SubmissionTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return SubmissionTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      waypointId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}waypoint_id']),
      type: stringType.mapFromDatabaseResponse(data['${effectivePrefix}type']),
      result:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}result']),
    );
  }
  factory SubmissionTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return SubmissionTableData(
      id: serializer.fromJson<int>(json['id']),
      waypointId: serializer.fromJson<String>(json['waypointId']),
      type: serializer.fromJson<String>(json['type']),
      result: serializer.fromJson<String>(json['result']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'waypointId': serializer.toJson<String>(waypointId),
      'type': serializer.toJson<String>(type),
      'result': serializer.toJson<String>(result),
    };
  }

  @override
  SubmissionTableCompanion createCompanion(bool nullToAbsent) {
    return SubmissionTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      waypointId: waypointId == null && nullToAbsent
          ? const Value.absent()
          : Value(waypointId),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      result:
          result == null && nullToAbsent ? const Value.absent() : Value(result),
    );
  }

  SubmissionTableData copyWith(
          {int id, String waypointId, String type, String result}) =>
      SubmissionTableData(
        id: id ?? this.id,
        waypointId: waypointId ?? this.waypointId,
        type: type ?? this.type,
        result: result ?? this.result,
      );
  @override
  String toString() {
    return (StringBuffer('SubmissionTableData(')
          ..write('id: $id, ')
          ..write('waypointId: $waypointId, ')
          ..write('type: $type, ')
          ..write('result: $result')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(waypointId.hashCode, $mrjc(type.hashCode, result.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is SubmissionTableData &&
          other.id == this.id &&
          other.waypointId == this.waypointId &&
          other.type == this.type &&
          other.result == this.result);
}

class SubmissionTableCompanion extends UpdateCompanion<SubmissionTableData> {
  final Value<int> id;
  final Value<String> waypointId;
  final Value<String> type;
  final Value<String> result;
  const SubmissionTableCompanion({
    this.id = const Value.absent(),
    this.waypointId = const Value.absent(),
    this.type = const Value.absent(),
    this.result = const Value.absent(),
  });
  SubmissionTableCompanion.insert({
    this.id = const Value.absent(),
    @required String waypointId,
    @required String type,
    @required String result,
  })  : waypointId = Value(waypointId),
        type = Value(type),
        result = Value(result);
  SubmissionTableCompanion copyWith(
      {Value<int> id,
      Value<String> waypointId,
      Value<String> type,
      Value<String> result}) {
    return SubmissionTableCompanion(
      id: id ?? this.id,
      waypointId: waypointId ?? this.waypointId,
      type: type ?? this.type,
      result: result ?? this.result,
    );
  }
}

class $SubmissionTableTable extends SubmissionTable
    with TableInfo<$SubmissionTableTable, SubmissionTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $SubmissionTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _waypointIdMeta = const VerificationMeta('waypointId');
  GeneratedTextColumn _waypointId;
  @override
  GeneratedTextColumn get waypointId => _waypointId ??= _constructWaypointId();
  GeneratedTextColumn _constructWaypointId() {
    return GeneratedTextColumn(
      'waypoint_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _resultMeta = const VerificationMeta('result');
  GeneratedTextColumn _result;
  @override
  GeneratedTextColumn get result => _result ??= _constructResult();
  GeneratedTextColumn _constructResult() {
    return GeneratedTextColumn(
      'result',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, waypointId, type, result];
  @override
  $SubmissionTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'submission_table';
  @override
  final String actualTableName = 'submission_table';
  @override
  VerificationContext validateIntegrity(SubmissionTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.waypointId.present) {
      context.handle(_waypointIdMeta,
          waypointId.isAcceptableValue(d.waypointId.value, _waypointIdMeta));
    } else if (waypointId.isRequired && isInserting) {
      context.missing(_waypointIdMeta);
    }
    if (d.type.present) {
      context.handle(
          _typeMeta, type.isAcceptableValue(d.type.value, _typeMeta));
    } else if (type.isRequired && isInserting) {
      context.missing(_typeMeta);
    }
    if (d.result.present) {
      context.handle(
          _resultMeta, result.isAcceptableValue(d.result.value, _resultMeta));
    } else if (result.isRequired && isInserting) {
      context.missing(_resultMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SubmissionTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return SubmissionTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(SubmissionTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.waypointId.present) {
      map['waypoint_id'] = Variable<String, StringType>(d.waypointId.value);
    }
    if (d.type.present) {
      map['type'] = Variable<String, StringType>(d.type.value);
    }
    if (d.result.present) {
      map['result'] = Variable<String, StringType>(d.result.value);
    }
    return map;
  }

  @override
  $SubmissionTableTable createAlias(String alias) {
    return $SubmissionTableTable(_db, alias);
  }
}

class MediaTableData extends DataClass implements Insertable<MediaTableData> {
  final int id;
  final String mediaId;
  final String fileUrl;
  final String key;
  final bool uploaded;
  MediaTableData(
      {@required this.id,
      @required this.mediaId,
      @required this.fileUrl,
      @required this.key,
      @required this.uploaded});
  factory MediaTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return MediaTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      mediaId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}media_id']),
      fileUrl: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}file_url']),
      key: stringType.mapFromDatabaseResponse(data['${effectivePrefix}key']),
      uploaded:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}uploaded']),
    );
  }
  factory MediaTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return MediaTableData(
      id: serializer.fromJson<int>(json['id']),
      mediaId: serializer.fromJson<String>(json['mediaId']),
      fileUrl: serializer.fromJson<String>(json['fileUrl']),
      key: serializer.fromJson<String>(json['key']),
      uploaded: serializer.fromJson<bool>(json['uploaded']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mediaId': serializer.toJson<String>(mediaId),
      'fileUrl': serializer.toJson<String>(fileUrl),
      'key': serializer.toJson<String>(key),
      'uploaded': serializer.toJson<bool>(uploaded),
    };
  }

  @override
  MediaTableCompanion createCompanion(bool nullToAbsent) {
    return MediaTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      mediaId: mediaId == null && nullToAbsent
          ? const Value.absent()
          : Value(mediaId),
      fileUrl: fileUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(fileUrl),
      key: key == null && nullToAbsent ? const Value.absent() : Value(key),
      uploaded: uploaded == null && nullToAbsent
          ? const Value.absent()
          : Value(uploaded),
    );
  }

  MediaTableData copyWith(
          {int id,
          String mediaId,
          String fileUrl,
          String key,
          bool uploaded}) =>
      MediaTableData(
        id: id ?? this.id,
        mediaId: mediaId ?? this.mediaId,
        fileUrl: fileUrl ?? this.fileUrl,
        key: key ?? this.key,
        uploaded: uploaded ?? this.uploaded,
      );
  @override
  String toString() {
    return (StringBuffer('MediaTableData(')
          ..write('id: $id, ')
          ..write('mediaId: $mediaId, ')
          ..write('fileUrl: $fileUrl, ')
          ..write('key: $key, ')
          ..write('uploaded: $uploaded')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(mediaId.hashCode,
          $mrjc(fileUrl.hashCode, $mrjc(key.hashCode, uploaded.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is MediaTableData &&
          other.id == this.id &&
          other.mediaId == this.mediaId &&
          other.fileUrl == this.fileUrl &&
          other.key == this.key &&
          other.uploaded == this.uploaded);
}

class MediaTableCompanion extends UpdateCompanion<MediaTableData> {
  final Value<int> id;
  final Value<String> mediaId;
  final Value<String> fileUrl;
  final Value<String> key;
  final Value<bool> uploaded;
  const MediaTableCompanion({
    this.id = const Value.absent(),
    this.mediaId = const Value.absent(),
    this.fileUrl = const Value.absent(),
    this.key = const Value.absent(),
    this.uploaded = const Value.absent(),
  });
  MediaTableCompanion.insert({
    this.id = const Value.absent(),
    @required String mediaId,
    @required String fileUrl,
    @required String key,
    @required bool uploaded,
  })  : mediaId = Value(mediaId),
        fileUrl = Value(fileUrl),
        key = Value(key),
        uploaded = Value(uploaded);
  MediaTableCompanion copyWith(
      {Value<int> id,
      Value<String> mediaId,
      Value<String> fileUrl,
      Value<String> key,
      Value<bool> uploaded}) {
    return MediaTableCompanion(
      id: id ?? this.id,
      mediaId: mediaId ?? this.mediaId,
      fileUrl: fileUrl ?? this.fileUrl,
      key: key ?? this.key,
      uploaded: uploaded ?? this.uploaded,
    );
  }
}

class $MediaTableTable extends MediaTable
    with TableInfo<$MediaTableTable, MediaTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $MediaTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _mediaIdMeta = const VerificationMeta('mediaId');
  GeneratedTextColumn _mediaId;
  @override
  GeneratedTextColumn get mediaId => _mediaId ??= _constructMediaId();
  GeneratedTextColumn _constructMediaId() {
    return GeneratedTextColumn(
      'media_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _fileUrlMeta = const VerificationMeta('fileUrl');
  GeneratedTextColumn _fileUrl;
  @override
  GeneratedTextColumn get fileUrl => _fileUrl ??= _constructFileUrl();
  GeneratedTextColumn _constructFileUrl() {
    return GeneratedTextColumn(
      'file_url',
      $tableName,
      false,
    );
  }

  final VerificationMeta _keyMeta = const VerificationMeta('key');
  GeneratedTextColumn _key;
  @override
  GeneratedTextColumn get key => _key ??= _constructKey();
  GeneratedTextColumn _constructKey() {
    return GeneratedTextColumn(
      'key',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uploadedMeta = const VerificationMeta('uploaded');
  GeneratedBoolColumn _uploaded;
  @override
  GeneratedBoolColumn get uploaded => _uploaded ??= _constructUploaded();
  GeneratedBoolColumn _constructUploaded() {
    return GeneratedBoolColumn(
      'uploaded',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, mediaId, fileUrl, key, uploaded];
  @override
  $MediaTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'media_table';
  @override
  final String actualTableName = 'media_table';
  @override
  VerificationContext validateIntegrity(MediaTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.mediaId.present) {
      context.handle(_mediaIdMeta,
          mediaId.isAcceptableValue(d.mediaId.value, _mediaIdMeta));
    } else if (mediaId.isRequired && isInserting) {
      context.missing(_mediaIdMeta);
    }
    if (d.fileUrl.present) {
      context.handle(_fileUrlMeta,
          fileUrl.isAcceptableValue(d.fileUrl.value, _fileUrlMeta));
    } else if (fileUrl.isRequired && isInserting) {
      context.missing(_fileUrlMeta);
    }
    if (d.key.present) {
      context.handle(_keyMeta, key.isAcceptableValue(d.key.value, _keyMeta));
    } else if (key.isRequired && isInserting) {
      context.missing(_keyMeta);
    }
    if (d.uploaded.present) {
      context.handle(_uploadedMeta,
          uploaded.isAcceptableValue(d.uploaded.value, _uploadedMeta));
    } else if (uploaded.isRequired && isInserting) {
      context.missing(_uploadedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MediaTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return MediaTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(MediaTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.mediaId.present) {
      map['media_id'] = Variable<String, StringType>(d.mediaId.value);
    }
    if (d.fileUrl.present) {
      map['file_url'] = Variable<String, StringType>(d.fileUrl.value);
    }
    if (d.key.present) {
      map['key'] = Variable<String, StringType>(d.key.value);
    }
    if (d.uploaded.present) {
      map['uploaded'] = Variable<bool, BoolType>(d.uploaded.value);
    }
    return map;
  }

  @override
  $MediaTableTable createAlias(String alias) {
    return $MediaTableTable(_db, alias);
  }
}

class HintsTableData extends DataClass implements Insertable<HintsTableData> {
  final int id;
  final String waypointId;
  final DateTime usedAt;
  HintsTableData(
      {@required this.id, @required this.waypointId, @required this.usedAt});
  factory HintsTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return HintsTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      waypointId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}waypoint_id']),
      usedAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}used_at']),
    );
  }
  factory HintsTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return HintsTableData(
      id: serializer.fromJson<int>(json['id']),
      waypointId: serializer.fromJson<String>(json['waypointId']),
      usedAt: serializer.fromJson<DateTime>(json['usedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'waypointId': serializer.toJson<String>(waypointId),
      'usedAt': serializer.toJson<DateTime>(usedAt),
    };
  }

  @override
  HintsTableCompanion createCompanion(bool nullToAbsent) {
    return HintsTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      waypointId: waypointId == null && nullToAbsent
          ? const Value.absent()
          : Value(waypointId),
      usedAt:
          usedAt == null && nullToAbsent ? const Value.absent() : Value(usedAt),
    );
  }

  HintsTableData copyWith({int id, String waypointId, DateTime usedAt}) =>
      HintsTableData(
        id: id ?? this.id,
        waypointId: waypointId ?? this.waypointId,
        usedAt: usedAt ?? this.usedAt,
      );
  @override
  String toString() {
    return (StringBuffer('HintsTableData(')
          ..write('id: $id, ')
          ..write('waypointId: $waypointId, ')
          ..write('usedAt: $usedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      $mrjf($mrjc(id.hashCode, $mrjc(waypointId.hashCode, usedAt.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is HintsTableData &&
          other.id == this.id &&
          other.waypointId == this.waypointId &&
          other.usedAt == this.usedAt);
}

class HintsTableCompanion extends UpdateCompanion<HintsTableData> {
  final Value<int> id;
  final Value<String> waypointId;
  final Value<DateTime> usedAt;
  const HintsTableCompanion({
    this.id = const Value.absent(),
    this.waypointId = const Value.absent(),
    this.usedAt = const Value.absent(),
  });
  HintsTableCompanion.insert({
    this.id = const Value.absent(),
    @required String waypointId,
    @required DateTime usedAt,
  })  : waypointId = Value(waypointId),
        usedAt = Value(usedAt);
  HintsTableCompanion copyWith(
      {Value<int> id, Value<String> waypointId, Value<DateTime> usedAt}) {
    return HintsTableCompanion(
      id: id ?? this.id,
      waypointId: waypointId ?? this.waypointId,
      usedAt: usedAt ?? this.usedAt,
    );
  }
}

class $HintsTableTable extends HintsTable
    with TableInfo<$HintsTableTable, HintsTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $HintsTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _waypointIdMeta = const VerificationMeta('waypointId');
  GeneratedTextColumn _waypointId;
  @override
  GeneratedTextColumn get waypointId => _waypointId ??= _constructWaypointId();
  GeneratedTextColumn _constructWaypointId() {
    return GeneratedTextColumn(
      'waypoint_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _usedAtMeta = const VerificationMeta('usedAt');
  GeneratedDateTimeColumn _usedAt;
  @override
  GeneratedDateTimeColumn get usedAt => _usedAt ??= _constructUsedAt();
  GeneratedDateTimeColumn _constructUsedAt() {
    return GeneratedDateTimeColumn(
      'used_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, waypointId, usedAt];
  @override
  $HintsTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'hints_table';
  @override
  final String actualTableName = 'hints_table';
  @override
  VerificationContext validateIntegrity(HintsTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.waypointId.present) {
      context.handle(_waypointIdMeta,
          waypointId.isAcceptableValue(d.waypointId.value, _waypointIdMeta));
    } else if (waypointId.isRequired && isInserting) {
      context.missing(_waypointIdMeta);
    }
    if (d.usedAt.present) {
      context.handle(
          _usedAtMeta, usedAt.isAcceptableValue(d.usedAt.value, _usedAtMeta));
    } else if (usedAt.isRequired && isInserting) {
      context.missing(_usedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HintsTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return HintsTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(HintsTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.waypointId.present) {
      map['waypoint_id'] = Variable<String, StringType>(d.waypointId.value);
    }
    if (d.usedAt.present) {
      map['used_at'] = Variable<DateTime, DateTimeType>(d.usedAt.value);
    }
    return map;
  }

  @override
  $HintsTableTable createAlias(String alias) {
    return $HintsTableTable(_db, alias);
  }
}

class AnswerTableData extends DataClass implements Insertable<AnswerTableData> {
  final int id;
  final String waypointId;
  final String submissionType;
  final String answer;
  AnswerTableData(
      {@required this.id,
      @required this.waypointId,
      @required this.submissionType,
      @required this.answer});
  factory AnswerTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return AnswerTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      waypointId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}waypoint_id']),
      submissionType: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}submission_type']),
      answer:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}answer']),
    );
  }
  factory AnswerTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return AnswerTableData(
      id: serializer.fromJson<int>(json['id']),
      waypointId: serializer.fromJson<String>(json['waypointId']),
      submissionType: serializer.fromJson<String>(json['submissionType']),
      answer: serializer.fromJson<String>(json['answer']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'waypointId': serializer.toJson<String>(waypointId),
      'submissionType': serializer.toJson<String>(submissionType),
      'answer': serializer.toJson<String>(answer),
    };
  }

  @override
  AnswerTableCompanion createCompanion(bool nullToAbsent) {
    return AnswerTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      waypointId: waypointId == null && nullToAbsent
          ? const Value.absent()
          : Value(waypointId),
      submissionType: submissionType == null && nullToAbsent
          ? const Value.absent()
          : Value(submissionType),
      answer:
          answer == null && nullToAbsent ? const Value.absent() : Value(answer),
    );
  }

  AnswerTableData copyWith(
          {int id, String waypointId, String submissionType, String answer}) =>
      AnswerTableData(
        id: id ?? this.id,
        waypointId: waypointId ?? this.waypointId,
        submissionType: submissionType ?? this.submissionType,
        answer: answer ?? this.answer,
      );
  @override
  String toString() {
    return (StringBuffer('AnswerTableData(')
          ..write('id: $id, ')
          ..write('waypointId: $waypointId, ')
          ..write('submissionType: $submissionType, ')
          ..write('answer: $answer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(waypointId.hashCode,
          $mrjc(submissionType.hashCode, answer.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is AnswerTableData &&
          other.id == this.id &&
          other.waypointId == this.waypointId &&
          other.submissionType == this.submissionType &&
          other.answer == this.answer);
}

class AnswerTableCompanion extends UpdateCompanion<AnswerTableData> {
  final Value<int> id;
  final Value<String> waypointId;
  final Value<String> submissionType;
  final Value<String> answer;
  const AnswerTableCompanion({
    this.id = const Value.absent(),
    this.waypointId = const Value.absent(),
    this.submissionType = const Value.absent(),
    this.answer = const Value.absent(),
  });
  AnswerTableCompanion.insert({
    this.id = const Value.absent(),
    @required String waypointId,
    @required String submissionType,
    @required String answer,
  })  : waypointId = Value(waypointId),
        submissionType = Value(submissionType),
        answer = Value(answer);
  AnswerTableCompanion copyWith(
      {Value<int> id,
      Value<String> waypointId,
      Value<String> submissionType,
      Value<String> answer}) {
    return AnswerTableCompanion(
      id: id ?? this.id,
      waypointId: waypointId ?? this.waypointId,
      submissionType: submissionType ?? this.submissionType,
      answer: answer ?? this.answer,
    );
  }
}

class $AnswerTableTable extends AnswerTable
    with TableInfo<$AnswerTableTable, AnswerTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $AnswerTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _waypointIdMeta = const VerificationMeta('waypointId');
  GeneratedTextColumn _waypointId;
  @override
  GeneratedTextColumn get waypointId => _waypointId ??= _constructWaypointId();
  GeneratedTextColumn _constructWaypointId() {
    return GeneratedTextColumn(
      'waypoint_id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _submissionTypeMeta =
      const VerificationMeta('submissionType');
  GeneratedTextColumn _submissionType;
  @override
  GeneratedTextColumn get submissionType =>
      _submissionType ??= _constructSubmissionType();
  GeneratedTextColumn _constructSubmissionType() {
    return GeneratedTextColumn(
      'submission_type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _answerMeta = const VerificationMeta('answer');
  GeneratedTextColumn _answer;
  @override
  GeneratedTextColumn get answer => _answer ??= _constructAnswer();
  GeneratedTextColumn _constructAnswer() {
    return GeneratedTextColumn(
      'answer',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, waypointId, submissionType, answer];
  @override
  $AnswerTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'answer_table';
  @override
  final String actualTableName = 'answer_table';
  @override
  VerificationContext validateIntegrity(AnswerTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.waypointId.present) {
      context.handle(_waypointIdMeta,
          waypointId.isAcceptableValue(d.waypointId.value, _waypointIdMeta));
    } else if (waypointId.isRequired && isInserting) {
      context.missing(_waypointIdMeta);
    }
    if (d.submissionType.present) {
      context.handle(
          _submissionTypeMeta,
          submissionType.isAcceptableValue(
              d.submissionType.value, _submissionTypeMeta));
    } else if (submissionType.isRequired && isInserting) {
      context.missing(_submissionTypeMeta);
    }
    if (d.answer.present) {
      context.handle(
          _answerMeta, answer.isAcceptableValue(d.answer.value, _answerMeta));
    } else if (answer.isRequired && isInserting) {
      context.missing(_answerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AnswerTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return AnswerTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(AnswerTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.waypointId.present) {
      map['waypoint_id'] = Variable<String, StringType>(d.waypointId.value);
    }
    if (d.submissionType.present) {
      map['submission_type'] =
          Variable<String, StringType>(d.submissionType.value);
    }
    if (d.answer.present) {
      map['answer'] = Variable<String, StringType>(d.answer.value);
    }
    return map;
  }

  @override
  $AnswerTableTable createAlias(String alias) {
    return $AnswerTableTable(_db, alias);
  }
}

class WaypointTableData extends DataClass
    implements Insertable<WaypointTableData> {
  final int id;
  final String waypointId;
  final String waypointJson;
  final bool passed;
  final bool synced;
  WaypointTableData(
      {@required this.id,
      @required this.waypointId,
      @required this.waypointJson,
      @required this.passed,
      @required this.synced});
  factory WaypointTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return WaypointTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      waypointId: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}waypoint_id']),
      waypointJson: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}waypoint_json']),
      passed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}passed']),
      synced:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}synced']),
    );
  }
  factory WaypointTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return WaypointTableData(
      id: serializer.fromJson<int>(json['id']),
      waypointId: serializer.fromJson<String>(json['waypointId']),
      waypointJson: serializer.fromJson<String>(json['waypointJson']),
      passed: serializer.fromJson<bool>(json['passed']),
      synced: serializer.fromJson<bool>(json['synced']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'waypointId': serializer.toJson<String>(waypointId),
      'waypointJson': serializer.toJson<String>(waypointJson),
      'passed': serializer.toJson<bool>(passed),
      'synced': serializer.toJson<bool>(synced),
    };
  }

  @override
  WaypointTableCompanion createCompanion(bool nullToAbsent) {
    return WaypointTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      waypointId: waypointId == null && nullToAbsent
          ? const Value.absent()
          : Value(waypointId),
      waypointJson: waypointJson == null && nullToAbsent
          ? const Value.absent()
          : Value(waypointJson),
      passed:
          passed == null && nullToAbsent ? const Value.absent() : Value(passed),
      synced:
          synced == null && nullToAbsent ? const Value.absent() : Value(synced),
    );
  }

  WaypointTableData copyWith(
          {int id,
          String waypointId,
          String waypointJson,
          bool passed,
          bool synced}) =>
      WaypointTableData(
        id: id ?? this.id,
        waypointId: waypointId ?? this.waypointId,
        waypointJson: waypointJson ?? this.waypointJson,
        passed: passed ?? this.passed,
        synced: synced ?? this.synced,
      );
  @override
  String toString() {
    return (StringBuffer('WaypointTableData(')
          ..write('id: $id, ')
          ..write('waypointId: $waypointId, ')
          ..write('waypointJson: $waypointJson, ')
          ..write('passed: $passed, ')
          ..write('synced: $synced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          waypointId.hashCode,
          $mrjc(waypointJson.hashCode,
              $mrjc(passed.hashCode, synced.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is WaypointTableData &&
          other.id == this.id &&
          other.waypointId == this.waypointId &&
          other.waypointJson == this.waypointJson &&
          other.passed == this.passed &&
          other.synced == this.synced);
}

class WaypointTableCompanion extends UpdateCompanion<WaypointTableData> {
  final Value<int> id;
  final Value<String> waypointId;
  final Value<String> waypointJson;
  final Value<bool> passed;
  final Value<bool> synced;
  const WaypointTableCompanion({
    this.id = const Value.absent(),
    this.waypointId = const Value.absent(),
    this.waypointJson = const Value.absent(),
    this.passed = const Value.absent(),
    this.synced = const Value.absent(),
  });
  WaypointTableCompanion.insert({
    this.id = const Value.absent(),
    @required String waypointId,
    @required String waypointJson,
    this.passed = const Value.absent(),
    this.synced = const Value.absent(),
  })  : waypointId = Value(waypointId),
        waypointJson = Value(waypointJson);
  WaypointTableCompanion copyWith(
      {Value<int> id,
      Value<String> waypointId,
      Value<String> waypointJson,
      Value<bool> passed,
      Value<bool> synced}) {
    return WaypointTableCompanion(
      id: id ?? this.id,
      waypointId: waypointId ?? this.waypointId,
      waypointJson: waypointJson ?? this.waypointJson,
      passed: passed ?? this.passed,
      synced: synced ?? this.synced,
    );
  }
}

class $WaypointTableTable extends WaypointTable
    with TableInfo<$WaypointTableTable, WaypointTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $WaypointTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _waypointIdMeta = const VerificationMeta('waypointId');
  GeneratedTextColumn _waypointId;
  @override
  GeneratedTextColumn get waypointId => _waypointId ??= _constructWaypointId();
  GeneratedTextColumn _constructWaypointId() {
    return GeneratedTextColumn('waypoint_id', $tableName, false,
        $customConstraints: 'UNIQUE');
  }

  final VerificationMeta _waypointJsonMeta =
      const VerificationMeta('waypointJson');
  GeneratedTextColumn _waypointJson;
  @override
  GeneratedTextColumn get waypointJson =>
      _waypointJson ??= _constructWaypointJson();
  GeneratedTextColumn _constructWaypointJson() {
    return GeneratedTextColumn(
      'waypoint_json',
      $tableName,
      false,
    );
  }

  final VerificationMeta _passedMeta = const VerificationMeta('passed');
  GeneratedBoolColumn _passed;
  @override
  GeneratedBoolColumn get passed => _passed ??= _constructPassed();
  GeneratedBoolColumn _constructPassed() {
    return GeneratedBoolColumn('passed', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _syncedMeta = const VerificationMeta('synced');
  GeneratedBoolColumn _synced;
  @override
  GeneratedBoolColumn get synced => _synced ??= _constructSynced();
  GeneratedBoolColumn _constructSynced() {
    return GeneratedBoolColumn('synced', $tableName, false,
        defaultValue: const Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, waypointId, waypointJson, passed, synced];
  @override
  $WaypointTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'waypoint_table';
  @override
  final String actualTableName = 'waypoint_table';
  @override
  VerificationContext validateIntegrity(WaypointTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.waypointId.present) {
      context.handle(_waypointIdMeta,
          waypointId.isAcceptableValue(d.waypointId.value, _waypointIdMeta));
    } else if (waypointId.isRequired && isInserting) {
      context.missing(_waypointIdMeta);
    }
    if (d.waypointJson.present) {
      context.handle(
          _waypointJsonMeta,
          waypointJson.isAcceptableValue(
              d.waypointJson.value, _waypointJsonMeta));
    } else if (waypointJson.isRequired && isInserting) {
      context.missing(_waypointJsonMeta);
    }
    if (d.passed.present) {
      context.handle(
          _passedMeta, passed.isAcceptableValue(d.passed.value, _passedMeta));
    } else if (passed.isRequired && isInserting) {
      context.missing(_passedMeta);
    }
    if (d.synced.present) {
      context.handle(
          _syncedMeta, synced.isAcceptableValue(d.synced.value, _syncedMeta));
    } else if (synced.isRequired && isInserting) {
      context.missing(_syncedMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaypointTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return WaypointTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(WaypointTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.waypointId.present) {
      map['waypoint_id'] = Variable<String, StringType>(d.waypointId.value);
    }
    if (d.waypointJson.present) {
      map['waypoint_json'] = Variable<String, StringType>(d.waypointJson.value);
    }
    if (d.passed.present) {
      map['passed'] = Variable<bool, BoolType>(d.passed.value);
    }
    if (d.synced.present) {
      map['synced'] = Variable<bool, BoolType>(d.synced.value);
    }
    return map;
  }

  @override
  $WaypointTableTable createAlias(String alias) {
    return $WaypointTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SubmissionsTableTable _submissionsTable;
  $SubmissionsTableTable get submissionsTable =>
      _submissionsTable ??= $SubmissionsTableTable(this);
  $SubmissionTableTable _submissionTable;
  $SubmissionTableTable get submissionTable =>
      _submissionTable ??= $SubmissionTableTable(this);
  $MediaTableTable _mediaTable;
  $MediaTableTable get mediaTable => _mediaTable ??= $MediaTableTable(this);
  $HintsTableTable _hintsTable;
  $HintsTableTable get hintsTable => _hintsTable ??= $HintsTableTable(this);
  $AnswerTableTable _answerTable;
  $AnswerTableTable get answerTable => _answerTable ??= $AnswerTableTable(this);
  $WaypointTableTable _waypointTable;
  $WaypointTableTable get waypointTable =>
      _waypointTable ??= $WaypointTableTable(this);
  @override
  List<TableInfo> get allTables => [
        submissionsTable,
        submissionTable,
        mediaTable,
        hintsTable,
        answerTable,
        waypointTable
      ];
}
