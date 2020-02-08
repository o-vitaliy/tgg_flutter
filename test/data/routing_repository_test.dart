import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/routing_repository.dart';
import 'package:tgg/models/routing.dart';

import 'mocks.dart';

main() {
  setUp(() {
    initLoginMock();
  });
  group("routing", () {
  /*  test("get real roting", () async {
      final ap = ApiProvider();
      ap.token = "4130190ba77daa1be884f8b66d3c2a4bcba45a11";
      final repo = RoutingRepo(
        apiProvider: ap,
      );
      
      final result = await repo.getRouting("5d6580bcd71f10000e0552c9");
      expect(result, isInstanceOf<Routing>());
    });*/


    test("load rouring", () async {
      final repo = RoutingRepo(
        apiProvider: mockedApiProvider,
      );

      final result = await repo.getRouting("5d6580bcd71f10000e0552c9");
      expect(result, isInstanceOf<Routing>());
      expect(result.modes.length, 4);
    });
  });

}
