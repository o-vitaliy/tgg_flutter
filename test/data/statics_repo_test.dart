import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/statics_repo.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("static_repo_test", () {
    test("blueprint", () async {
      StaticRepo staticRepo = StaticRepo(
          staticApiProvider: mockedStaticApiProvider,
          apiProvider: mockedApiProvider);
      final b = await staticRepo.getBluePrint();
      expect(b, containsPair("name", "gogame"));
    });

    test("flavor", () async {
      StaticRepo staticRepo = StaticRepo(
          staticApiProvider: mockedStaticApiProvider,
          apiProvider: mockedApiProvider);
      final f = await staticRepo.getFlavor("gogame");
      expect(f, containsPair("facebook:color", "#3b5998"));
    });

    test("flavor for not default blueprint id", () async {
      StaticRepo staticRepo = StaticRepo(
          staticApiProvider: mockedStaticApiProvider,
          apiProvider: mockedApiProvider);
      final f = await staticRepo.getFlavor("not default");
      expect(f, containsPair("facebook:color", "#ffffff"));
    });

    test("flavor for default blueprint id", () async {
      StaticRepo staticRepo = StaticRepo(
          staticApiProvider: mockedStaticApiProvider,
          apiProvider: mockedApiProvider);
      final f = await staticRepo.getFlavor("gogame");

      expect(f, containsPair("facebook:color", "#3b5998"));
    });
  });
}
