import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/data/providers.dart';

main() {
  group("static_repo_test", () {
    test("blueprint", () async {
      final b = await staticRepo.getBluePrint();
      expect(b, containsPair("name", "gogame"));
    });
    test("flavor", () async {
      final f = await staticRepo.getFlavor();
      expect(f, containsPair("primary.color", "#f47421"));
    });
  });
}
