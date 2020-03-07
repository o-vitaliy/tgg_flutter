import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

main() {
  group("mode", () {
    test("fromString", () {
      expect(ModeHelper.fromString("main"), isInstanceOf<MainMode>());
      expect(ModeHelper.fromString("anytime"), isInstanceOf<AnytimeMode>());
      expect(ModeHelper.fromString("camera"), isInstanceOf<CameraMode>());
      expect(ModeHelper.fromString("head_to_head"), isInstanceOf<H2HMode>());
    });

    test("name", () {
      expect(MainMode().name, "main");
      expect(AnytimeMode().name, "anytime");
      expect(CameraMode().name, "camera");
      expect(H2HMode().name, "head_to_head");
    });
  });
}
