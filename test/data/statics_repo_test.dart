import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tgg/data/statics_repo.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("static_repo_test", () {
    test("default", () async {
      StaticRepo staticRepo = StaticRepo(apiProvider: mockedApiProvider);
      final f = await staticRepo.getFlavor("flavor");
      expect(f, isNotNull);
      expect(f, containsPair("facebook:color", "#3b5998"));
      expect(f, containsPair("global:pts", "pts"));
    });
    test("game", () async {
      StaticRepo staticRepo = StaticRepo(apiProvider: mockedApiProvider);
      final f = await staticRepo.getGameFlavor("flavor", "gameid");
      expect(f, isNotNull);
      expect(f, containsPair("facebook:color", "#3b5998"));
      expect(f, containsPair("global:pts", "ptsssss"));
    });
    test("check if cached", () async {
      StaticRepo staticRepo = StaticRepo(apiProvider: mockedApiProvider);
      await staticRepo.getFlavor("a_flavor");
      await staticRepo.getFlavor("a_flavor");
      await staticRepo.getFlavor("a_flavor");

      verify(mockedApiProvider.getFlavor("a_flavor")).called(1);
    });
  });
}
