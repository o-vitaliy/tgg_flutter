import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/playthrough_status.dart';

main() {
  group("PlaythroughStatus", () {
    test("check all", () {
      final List<PlaythroughStatus> values =
      List<PlaythroughStatus>.from(PlaythroughStatus.values);
      final List<int> codes = [100, 300, 400, 500, 600, 700, 800];

      codes.forEach((code) {
        final status = PlaythroughStatusHelper.getFromInt(code);
        expect(status, isNotNull);
        values.remove(status);
      });
      expect(values.isEmpty, true);
    });

    test("check every", () {
      expect(PlaythroughStatusHelper.getFromInt(100), PlaythroughStatus.closed);
      expect(
          PlaythroughStatusHelper.getFromInt(300), PlaythroughStatus.started);
      expect(PlaythroughStatusHelper.getFromInt(400), PlaythroughStatus.paused);
      expect(PlaythroughStatusHelper.getFromInt(500), PlaythroughStatus.ending);
      expect(PlaythroughStatusHelper.getFromInt(600), PlaythroughStatus.ended);
      expect(PlaythroughStatusHelper.getFromInt(700), PlaythroughStatus.voting);
      expect(
          PlaythroughStatusHelper.getFromInt(800), PlaythroughStatus.archived);
    });
  });
}
