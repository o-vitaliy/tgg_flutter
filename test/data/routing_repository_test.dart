import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/routing_repository.dart';
import 'package:tgg/models/routing.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("routing", () {
    test("load routing", () async {
      final repo = RoutingRepo(
        apiProvider: mockedApiProvider,
      );

      final result = await repo.getRouting("mockRouting");
      expect(result, isInstanceOf<Routing>());
      expect(result.modes.length, 4);
    });
  });
}
