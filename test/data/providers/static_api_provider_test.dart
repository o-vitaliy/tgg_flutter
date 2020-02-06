import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/providers/static_api_provider.dart';

main() {
  final apiStaticProvider = StaticApiProvider();
  group("static_api_provider_test", () {
    test("bluepront", () async {
      final b = await apiStaticProvider.fetchBlueprint();
      expect(b, stringContainsInOrder(["name"]));
    });
  });
}
