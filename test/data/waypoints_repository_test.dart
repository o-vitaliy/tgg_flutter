import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/data/dao/dao_answer.dart';
import 'package:tgg/data/dao/dao_hints.dart';
import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/dao/dao_submission.dart';
import 'package:tgg/data/dao/dao_waypoints.dart';
import 'package:tgg/data/dao/db.dart';
import 'package:tgg/data/waypoint_repository.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

import 'mocks.dart';

main() {
  AppDatabase database;
  DaoSubmission daoSubmission;
  DaoMedia daoMedia;
  DaoHint daoHint;
  DaoAnswer daoAnswer;
  DaoWaypoint daoWaypoint;

  WaypointsRepo repo;

  final waypointId = "waypointId";
  final lat = 1.0;
  final lng = 2.0;
  final accuracy = 3.0;
  final position = Position.fromMap({
    'latitude': lat,
    'longitude': lng,
    'accuracy': accuracy,
  });
  setUp(() {
    initLoginMock();

    database = AppDatabase(executor: VmDatabase.memory());
    daoSubmission = DaoSubmission(database);
    daoMedia = DaoMedia(database);
    daoHint = DaoHint(database);
    daoAnswer = DaoAnswer(database);
    daoWaypoint = DaoWaypoint(database);

    when(mockedLocationProvider.getLocation())
        .thenAnswer((_) => Future.value(position));

    repo = WaypointsRepo(
      apiProvider: mockedApiProvider,
      daoSubmission: daoSubmission,
      daoMedia: daoMedia,
      daoAnswer: daoAnswer,
      daoHint: daoHint,
      locationProvider: mockedLocationProvider,
      daoWaypoint: daoWaypoint,
    );
  });

  tearDown(() async {
    await database.close();
  });
  group("waypoints", () {
    test("active_waypoints", () async {
      final waypoints = await repo.getActiveWaypoints();

      waypoints.forEach((wp) {
        wp.step.behavior.submissionType.forEach((s) {
          expect(SubmissionTypeHelper.fromString(s.type), isNotNull);
        });
      });
    });

    test("check all waypoints in database", () async {
      final waypoints = await repo.getActiveWaypoints();

      waypoints.forEach((wp) async {
        final waypointId = wp.id;
        final waypointIdFromDb =
            (await daoWaypoint.getWaypoint(waypointId)).waypointId;
        expect(waypointIdFromDb, waypointId);
      });
    });

    test("track start", () async {
      await repo.trackStart(waypointId);

      verify(
        mockedApiProvider.waypointTriggerAction(
          values: anyNamed("values"),
          waypointId: waypointId,
        ),
      ).called(1);

      final submissions = await daoSubmission.findById(waypointId);
      expect(submissions.waypointId, waypointId);
      expect(submissions.startedAt.millisecondsSinceEpoch, isPositive);
      expect(submissions.startedLocationLat, lat);
      expect(submissions.startedLocationLng, lng);
    });

    test("submit answer ganerates valid json", () async {
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));

      final waypoints = await repo.getActiveWaypoints();
      final waypointId = waypoints.first.id;

      daoHint.getUsedHints(waypointId);
      daoAnswer.insert(waypointId, "text", "a1", DateTime.now());
      daoAnswer.insert(waypointId, "text", "a2", DateTime.now());
      daoAnswer.insert(waypointId, "number", "a1", DateTime.now());
      daoAnswer.insert(waypointId, "number", "a2", DateTime.now());

      await repo.submitAnswer(waypointId);

      verify(mockedApiProvider.waypointTriggerAction(
        values: argThat(predicate((params) {
          return json.encode(params) != null;
        }), named: "values"),
        waypointId: anyNamed("waypointId"),
      ));
    });

    test("check params order valid", () async {
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));

      final waypoints = await repo.getActiveWaypoints();
      final waypointId = waypoints.first.id;

      final date1 = DateTime.now();
      daoAnswer.insert(waypointId, "number", "n0", date1);
      daoAnswer.insert(waypointId, "text", "a0", date1);

      final date2 = date1.add(Duration(seconds: 1));
      daoAnswer.insert(waypointId, "number", "n2", date2);
      daoAnswer.insert(waypointId, "text", "a2", date2);

      await repo.submitAnswer(waypointId);

      verify(mockedApiProvider.waypointTriggerAction(
        values: argThat(predicate((params) {
          final submissions = params["params"]["submissions"];
          expect(submissions, isNotNull);
          expect(submissions.length, 2);

          final submission0 = submissions[0]["submission"];
          expect(submission0[0]["number"], "n0");
          expect(submission0[1]["text"], "a0");

          final submission1 = submissions[1]["submission"];
          expect(submission1[0]["number"], "n2");
          expect(submission1[1]["text"], "a2");
          return true;
        }), named: "values"),
        waypointId: anyNamed("waypointId"),
      ));
    });

    test("sumbit answer without media", () async {
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));

      final waypoints = await repo.getActiveWaypoints();
      final waypointId = waypoints.first.id;

      final date = DateTime.now();
      final date2 = date.add(Duration(seconds: 1));
      daoHint.getUsedHints(waypointId);
      daoAnswer.insert(waypointId, "text", "a1", date);
      daoAnswer.insert(waypointId, "text", "a2", date);
      daoAnswer.insert(waypointId, "number", "a1", date2);
      daoAnswer.insert(waypointId, "number", "a2", date2);

      await repo.submitAnswer(waypointId);

      verify(mockedApiProvider.waypointTriggerAction(
        waypointId: anyNamed("waypointId"),
        values: argThat(predicate((params) {
          final v = params["params"];
          final f0 = v["num_hints_used"] == 0;
          final f1 = v["submissions"][0]["submission"][0]["text"] == "a1" &&
              v["submissions"][0]["submission"][1]["text"] == "a2";
          final f2 = v["submissions"][1]["submission"][0]["number"] == "a1" &&
              v["submissions"][1]["submission"][1]["number"] == "a2";
          return f0 && f1 && f2;
        }), named: "values"),
      )).called(1);
    });
    test("sumbit answer with media", () async {
      final waypoints = await repo.getActiveWaypoints();
      final waypointId = waypoints.first.id;

      await daoMedia.insert("mediaId", "url", "key");
      daoAnswer.insert(waypointId, "photo", "url", DateTime.now());

      await repo.submitAnswer(waypointId);

      verify(mockedApiProvider.waypointTriggerAction(
        values: argThat(predicate((params) {
          final v = params["params"];
          return v["media"][0] == "mediaId" &&
              v["submissions"][0]["submission"][0]["photo"] == "mediaId";
        }), named: "values"),
        waypointId: anyNamed("waypointId"),
      ));
    });
    test("sumbit answer checkbox", () async {
      final waypoints = await repo.getActiveWaypoints();
      final waypointId = waypoints.first.id;

      daoAnswer.insert(waypointId, "checkboxes", "a1,a2", DateTime.now());

      await repo.submitAnswer(waypointId);

      verify(mockedApiProvider.waypointTriggerAction(
        values: argThat(predicate((params) {
          final v = params["params"];
          return listEquals(
              v["submissions"][0]["submission"][0]["checkboxes"], ["a1", "a2"]);
        }), named: "values"),
        waypointId: anyNamed("waypointId"),
      ));
    });

    test("sumbit passed and sync flags", () async {
      final waypointId = (await repo.getActiveWaypoints()).first.id;

      daoAnswer.insert(waypointId, "checkboxes", "a1,a2", DateTime.now());

      await repo.submitAnswer(waypointId);

      final result = await daoWaypoint.getWaypoint(waypointId);
      expect(result.passed, true);
      expect(result.synced, true);
    });

    test("sumbit getActiveWaypoints twice", () async {
      await repo.getActiveWaypoints();
      await repo.getActiveWaypoints();
    });

    test("all modes", () async {
      when(mockedApiProvider.activeWaypoints()).thenAnswer((_) => Future.value(
          File("test/data/mocks/activeWaypointAllModes.json")
              .readAsStringSync()));

      final waypoints = await repo.getActiveWaypoints();
      expect(waypoints.where((w) => w.mode == Mode.main), isNotEmpty);
      expect(waypoints.where((w) => w.mode == Mode.head_to_head), isNotEmpty);
      expect(waypoints.where((w) => w.mode == Mode.camera), isNotEmpty);
      expect(waypoints.where((w) => w.mode == Mode.anytime), isNotEmpty);
    });
  });
}
