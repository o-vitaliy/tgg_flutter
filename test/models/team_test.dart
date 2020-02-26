import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/challenge_state.dart';
import 'package:tgg/models/team.dart';

const _json = """
{"team":{"id":"5e5678ced71f1000340c98aa","name":"Team #10","pin":"yxk","number":10,"track":10,"game_runner":false,"is_archived":false,"external_user_id":null,"profile":{},"social_info":{},"status":200,"history":["anytime:anytime"],"challenges":[{"state":"sent","updated_at":"2020-02-26T14:02:01+0000","team":"5e567981d71f1000340c98b3","team_name":"Team #11","mode_name":"head_to_head","message":null}],"progress":{"points":0},"last_logged_in_at":null,"last_location":[30.4088266,50.4589409],"last_located_at":"2020-02-26T16:11:12+0000","last_location_accuracy":800.0,"points_total":0,"points_from_play":0,"points_from_voting":0,"playthrough_id":"5e55230bd71f1000218afa92"},"token":"71c60848c27b671e7ab000f96172627790b61e85"}
""";
const _jsonWithSentInvite = _json;

const _jsonWithReceivedInvite = """
{"team":{"id":"5e5678ced71f1000340c98aa","name":"Team #10","pin":"yxk","number":10,"track":10,"game_runner":false,"is_archived":false,"external_user_id":null,"profile":{},"social_info":{},"status":200,"history":["anytime:anytime"],"challenges":[{"state":"received","updated_at":"2020-02-26T14:02:01+0000","team":"5e567981d71f1000340c98b3","team_name":"Team #11","mode_name":"head_to_head","message":null}],"progress":{"points":0},"last_logged_in_at":null,"last_location":[30.4088266,50.4589409],"last_located_at":"2020-02-26T16:11:12+0000","last_location_accuracy":800,"points_total":0,"points_from_play":0,"points_from_voting":0,"playthrough_id":"5e55230bd71f1000218afa92"},"token":"71c60848c27b671e7ab000f96172627790b61e85"}
""";

main() {
  group("Team", () {
    test("check chellange as map", () {
      final team = Team.fromJsonMap(json.decode(_json)["team"]);
      expect(team, isNotNull);
      expect(team.id, "5e5678ced71f1000340c98aa");
      expect(team.name, "Team #10");
      expect(team.pin, "yxk");
      expect(team.status, 200);
      expect(team.playthroughId, "5e55230bd71f1000218afa92");
      expect(team.challenges, isNotNull);
      expect(team.challenges.length, 1);
      expect(team.challenges[0].teamId, "5e567981d71f1000340c98b3");
      expect(team.challenges[0].teamName, "Team #11");
      expect(team.challenges[0].state, ChallengeState.sent);
    });
  });

  group("getWaitingOpponentToAccept", () {
    test("present", () {
      final team = Team.fromJsonMap(json.decode(_jsonWithSentInvite)["team"]);
      final challenge = team.getWaitingOpponentToAccept();
      expect(challenge, isNotNull);
    });
  });

  group("getReceivedInvite", () {
    test("present", () {
      final team =
          Team.fromJsonMap(json.decode(_jsonWithReceivedInvite)["team"]);
      final challenge = team.getReceivedInvite();
      expect(challenge, isNotNull);
    });
  });
}
