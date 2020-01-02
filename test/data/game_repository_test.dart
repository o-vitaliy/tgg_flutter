import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/playthrought_repository.dart';
import 'package:tgg/data/statics_repo.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("playthrough", () {
    test("getPlaythrough", () async {
      final repo = PlaythroughRepo(
          apiProvider: mockedApiProvider,
          staticRepo: StaticRepo(apiProvider: mockedStaticApiProvider,),);
      final response = await repo.getPlaythrough(playthroughs);
      expect(response.id, equals("5e07304dd71f10001a444b3b"));
    });
  });
}
