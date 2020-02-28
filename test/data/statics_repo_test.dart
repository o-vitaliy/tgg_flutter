import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/statics_repo.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("static_repo_test", () {
    test("flavor", () async {
      StaticRepo staticRepo = StaticRepo(apiProvider: mockedApiProvider);
      final f = await staticRepo.getFlavor("flavor", "gameid");
      expect(f, isNotNull);
      expect(f, containsPair("facebook:color", "#3b5998"));
      expect(f, containsPair("global:pts", "ptsssss"));
    });
  });
}
