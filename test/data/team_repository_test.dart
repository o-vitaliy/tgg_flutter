import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/team_repo.dart';
import 'package:tgg/models/team.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("team", () {
    test("load", () async {
      final repo = TeamRepo(
        apiProvider: mockedApiProvider,
      );

      final result = await repo.updateTeam("5d6580bcd71f10000e0552c9");
      expect(result, isInstanceOf<Team>());
      expect(result.id, "5e0dd20bd71f100014a5d10f");
      expect(result.playthroughId, "5e07304dd71f10001a444b3b");
    });
  });
}
