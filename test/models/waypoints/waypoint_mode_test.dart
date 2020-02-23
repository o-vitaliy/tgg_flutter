import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

main() {
  group("mode", () {
    test("fromString", () {
      expect(ModeHelper.fromString("main"), Mode.main);
      expect(ModeHelper.fromString("anytime"), Mode.anytime);
    });

    test("toString", () {
      Mode.values.forEach((mode) {
        final string = ModeHelper.to(mode);
        expect(ModeHelper.fromString(string), mode);
      });
    });
  });
}
