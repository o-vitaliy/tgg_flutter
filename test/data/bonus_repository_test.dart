import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tgg/data/bonus_repo.dart';
import 'package:tgg/data/waypoint_repository.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

import 'mocks.dart';

class MockedWaypointsRepo extends Mock implements WaypointsRepo {}

main() {
  MockedWaypointsRepo waypointsRepo = MockedWaypointsRepo();

  BonusRepo repo;
  setUp(() {
    initLoginMock();

    when(waypointsRepo.getActiveWaypoints("team_id")).thenAnswer((_) =>
        json.decode(mockedActiveWaypoints).map((w) => Waypoint.fromJsonMap(w)));

    repo = BonusRepo(
      apiProvider: mockedApiProvider,
      waypointsRepo: MockedWaypointsRepo(),
    );
  });
  group("bonus", () {
    test("get", () async {
      final response = await repo.getMissions("team_id");
      expect(response[0].id, "5e4c3fe0d71f10001ee928a4");
      expect(response[0].name, "Any time text");
    });
  });
}
