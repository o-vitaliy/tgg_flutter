import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mockito/mockito.dart';
import 'package:moor_ffi/moor_ffi.dart';
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
  });
}
