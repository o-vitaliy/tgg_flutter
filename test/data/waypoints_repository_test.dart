import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/waypoint_repository.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("waypoints", () {
    test("active_waypints", () async {
      final repo = WaypointsRepo(apiProvider: mockedApiProvider);
      final waypoints = await repo.getActiveWaypoints();

      expect(waypoints.first.step.behavior.submissionType.first.type, equals("text"));
      expect(waypoints.last.step.behavior.submissionType.first.type, equals("photo"));
    });
  });
}
