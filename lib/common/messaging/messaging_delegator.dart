import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:tgg/containers/h2h/h2h_actions.dart';
import 'package:tgg/models/challenge_invite.dart';
import 'package:tgg/models/challenge_invite_accepted.dart';
import 'package:tgg/models/challenge_result.dart';
import 'package:tgg/redux_model/app_state.dart';

const _challengeReceived = "challenge-received";
const _challengeAccepted = "challenge-accepted";
const _challengeDeclined = "challenge-declined";
const _challengeFinished = "challenge-finished";

class MessageDelegator {
  final Store<AppState> _store;

  MessageDelegator(this._store);

  void delegate(Map<String, dynamic> event) {
    final eventName = event["event"];

    switch (eventName) {
      case _challengeReceived:
        final value = ChallengeInvite.fromJsonMap(json.decode(event["params"]));
        _store.dispatch(H2HReceiveInviteAction(value.teamId, value.teamName));
        break;
      case _challengeAccepted:
      case _challengeDeclined:
        final value = ChallengeInviteAccepted.fromJsonMap(
          json.decode(event["params"]),
          eventName == _challengeAccepted,
        );
        _store.dispatch(H2HInviteAcceptedAction(
          value.teamId,
          value.teamName,
          value.accepted,
        ));
        break;
      case _challengeFinished:
        final value = ChallengeResult.fromJsonMap(json.decode(event["params"]));
        _store.dispatch(H2HResultAction(value));
        break;
    }
  }
}
