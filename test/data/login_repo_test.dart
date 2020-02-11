import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/login_repo.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("login_repo_test", () {
    test("goodLogin", () async {
      final repo =
          LoginRepo(apiProvider: mockedApiProvider, prefs: mockedPrefs);
      final response = await repo.login(code: goodPin);
      expect(response.team.id, equals("5e0dd20bd71f100014a5d10f"));
    });
    test("badLogin", () async {
      final repo =
          LoginRepo(apiProvider: mockedApiProvider, prefs: mockedPrefs);
      final response = repo.login(code: badPin, pin: "");
      expect(response, throwsA(equals(mockedLoginErrorResponse)));
    });
  });
}
