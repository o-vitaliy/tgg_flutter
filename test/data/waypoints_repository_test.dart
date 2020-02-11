import 'dart:convert';

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

    test("sumbit answer ganerates valid json", () async {
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));

      final waypointId = "waypointId";

      daoHint.getUsedHints(waypointId);
      daoAnswer.insert(waypointId, "text", "a1");
      daoAnswer.insert(waypointId, "text", "a2");
      daoAnswer.insert(waypointId, "number", "a1");
      daoAnswer.insert(waypointId, "number", "a2");

      await repo.submitAnswer(waypointId);

      verify(mockedApiProvider.waypointTriggerAction(
        values: argThat(predicate((params) {
          return json.encode(params) != null;
        }), named: "values"),
        waypointId: anyNamed("waypointId"),
      ));
    });

    test("sumbit answer without media", () async {
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));

      final waypointId = "waypointId";

      daoHint.getUsedHints(waypointId);
      daoAnswer.insert(waypointId, "text", "a1");
      daoAnswer.insert(waypointId, "text", "a2");
      daoAnswer.insert(waypointId, "number", "a1");
      daoAnswer.insert(waypointId, "number", "a2");

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
      final waypointId = "waypointId";

      await daoMedia.insert("mediaId", "url", "key");
      daoAnswer.insert(waypointId, "photo", "key");

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
      final waypointId = "waypointId";

      daoAnswer.insert(waypointId, "checkboxes", "a1,a2");

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

      daoAnswer.insert(waypointId, "checkboxes", "a1,a2");

      await repo.submitAnswer(waypointId);

      final result = await daoWaypoint.getWaypoint(waypointId);
      expect(result.passed, true);
      expect(result.synced, true);
    });

    test("sumbit getActiveWaypoints twice", () async {
      await repo.getActiveWaypoints();
      await repo.getActiveWaypoints();
    });
  });
}
