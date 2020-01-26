import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:moor_ffi/moor_ffi.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/dao/dao_submission.dart';
import 'package:tgg/data/dao/db.dart';
import 'package:tgg/data/waypoint_repository.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("waypoints", () {
    test("active_waypints", () async {
      final repo = WaypointsRepo(
          apiProvider: mockedApiProvider,
          daoSubmission:
              DaoSubmission(AppDatabase(executor: VmDatabase.memory())),
          daoMedia: DaoMedia(AppDatabase(executor: VmDatabase.memory())),
          locationProvider: mockedLocationProvider);
      final waypoints = await repo.getActiveWaypoints();

      expect(waypoints.first.step.behavior.submissionType.first.type,
          equals("text"));
      expect(waypoints.last.step.behavior.submissionType.first.type,
          equals("movie"));
    });

    test("track start", () async {
      final lat = 1.0;
      final lng = 2.0;
      final accuracy = 3.0;
      final waypointId = "waypointId";
      final position = Position.fromMap({
        'latitude': lat,
        'longitude': lng,
        'accuracy': accuracy,
      });
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));
      final daoSubmission =
          DaoSubmission(AppDatabase(executor: VmDatabase.memory()));
      final repo = WaypointsRepo(
        apiProvider: mockedApiProvider,
        daoSubmission: daoSubmission,
        daoMedia: DaoMedia(AppDatabase(executor: VmDatabase.memory())),
        locationProvider: mockedLocationProvider,
      );
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

    test("sumbit answer without media", () async {
      final lat = 1.0;
      final lng = 2.0;
      final accuracy = 3.0;
      final position = Position.fromMap({
        'latitude': lat,
        'longitude': lng,
        'accuracy': accuracy,
      });
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));
      final daoSubmission =
          DaoSubmission(AppDatabase(executor: VmDatabase.memory()));
      final daoMedia = DaoMedia(AppDatabase(executor: VmDatabase.memory()));
      final repo = WaypointsRepo(
        apiProvider: mockedApiProvider,
        daoSubmission: daoSubmission,
        daoMedia: daoMedia,
        locationProvider: mockedLocationProvider,
      );

      final waypoint = (await repo.getActiveWaypoints()).firstWhere(
          (w) => w.step.behavior.submissionType.first.type == "text");
      WaypointSubmissionItem submissionItem = WaypointSubmissionItem.initial(
              waypoint.step.behavior.submissionType.first)
          .copyWith(answer: "answer");
      await repo.submitAnswer(waypoint, [submissionItem]);

      verify(mockedApiProvider.waypointTriggerAction(
        values:
            argThat(predicate((v) => json.encode(v) != null), named: "values"),
        waypointId: anyNamed("waypointId"),
      ));
    });
    test("sumbit answer with media", () async {
      final lat = 1.0;
      final lng = 2.0;
      final accuracy = 3.0;
      final position = Position.fromMap({
        'latitude': lat,
        'longitude': lng,
        'accuracy': accuracy,
      });
      when(mockedLocationProvider.getLocation())
          .thenAnswer((_) => Future.value(position));
      final daoSubmission =
          DaoSubmission(AppDatabase(executor: VmDatabase.memory()));
      final daoMedia = DaoMedia(AppDatabase(executor: VmDatabase.memory()));
      await daoMedia.insert("mediaId", "url", "key");
      final repo = WaypointsRepo(
        apiProvider: mockedApiProvider,
        daoSubmission: daoSubmission,
        daoMedia: daoMedia,
        locationProvider: mockedLocationProvider,
      );

      final waypoint = (await repo.getActiveWaypoints()).firstWhere(
          (w) => w.step.behavior.submissionType.first.type == "photo");
      WaypointSubmissionItem submissionItem = WaypointSubmissionItem.initial(
              waypoint.step.behavior.submissionType.first)
          .copyWith(answer: "key", media: "key");
      await repo.submitAnswer(waypoint, [submissionItem]);

      verify(mockedApiProvider.waypointTriggerAction(
        values: argThat(predicate((v) {
          return v["params"]["media"][0] == "mediaId";
        }), named: "values"),
        waypointId: anyNamed("waypointId"),
      ));
    });
  });
}
