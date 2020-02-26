import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/challenge_invite_result.dart';

final _jsonSent = File("test/data/mocks/invited.json").readAsStringSync();
final _json = File("test/data/mocks/invitedFailed.json").readAsStringSync();

main() {
  group("ChallangeInviteResult", () {
    test("parse error", () {
      final map = json.decode(_json);
      final result = ChallengeInviteResult.fromJsonMap(map);
      final status = result.status;
      expect(status.isOk, false);
      expect(status.result, "self_busy");
      expect(status.teamName, "Team #451");
    });

    test("parse ok", () {
      final map = json.decode(_jsonSent);
      final result = ChallengeInviteResult.fromJsonMap(map);
      final status = result.status;
      expect(status.isOk, true);
      expect(status.result, "sent");
      expect(status.teamName, isNull);
    });
  });
}
