import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/playthrought_repository.dart';
import 'package:tgg/models/playthrough_status.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("playthrough", () {
    test("getPlaythrough", () async {
      final repo = PlaythroughRepo(
        apiProvider: mockedApiProvider,
      );
      final response = await repo.getPlaythrough(playthroughs);
      expect(response.id, equals("5e07304dd71f10001a444b3b"));
      expect(response.startedAt, isNotNull);
      expect(response.status, PlaythroughStatus.started);
    });
  });
}
