import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/location_provider.dart';
import 'package:tgg/models/challenge_invite_result.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

class H2HRepo {
  final ApiProvider apiProvider;
  final FirebaseMessaging firebaseMessaging;
  final LocationProvider locationProvider;

  H2HRepo({
    @required this.apiProvider,
    @required this.firebaseMessaging,
    @required this.locationProvider,
  });

  Future registerFcm(final String teamId) async {
    final token = await firebaseMessaging.getToken();
    return apiProvider.teamTriggerAction(teamId: teamId, values: {
      "name": "subscribe_to_topic",
      "params": {
        "registration_token": token,
      }
    });
  }

  Future<ChallengeInviteResult> invite(
    final String teamId,
    final String opponentPin,
  ) async {
    final location = await locationProvider.getLocation();
    final locationFix = locationProvider.toFix(location);
    final response =
        await apiProvider.teamTriggerAction(teamId: teamId, values: {
      "name": "challenge",
      "params": {
        "mode_name": ModeHelper.to(Mode.head_to_head),
        "team_id": opponentPin,
        "action": "send",
        "location_fix": locationFix
      }
    });

    final map = json.decode(response);
    return ChallengeInviteResult.fromJsonMap(map);
  }

  Future<ChallengeInviteResult> acceptInvite(
      final String teamId, final opponentTeamId, final bool accepted) async {
    final response =
        await apiProvider.teamTriggerAction(teamId: teamId, values: {
      "name": "challenge",
      "params": {
        "mode_name": ModeHelper.to(Mode.head_to_head),
        "team_id": opponentTeamId,
        "action": accepted ? "accept" : "decline"
      }
    });

    final map = json.decode(response);
    return ChallengeInviteResult.fromJsonMap(map);
  }
}
