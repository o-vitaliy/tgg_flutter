import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/challenge_invite.dart';

const _json = """
{"event": "challenge-received", "params": {"team_id": "5e52a6c4d71f10001a48a104", "mode_name": "head_to_head"}}
""";

main() {
  group("ChallangeInvite", () {
    test("parse", () {
      final event = json.decode(_json);
      final result = ChallengeInvite.fromJsonMap(event["params"]);
      expect(result.teamId, isNotNull);
      expect(result.modeName, isNotNull);
    });
  });
}
