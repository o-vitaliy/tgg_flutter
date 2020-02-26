import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:tgg/models/challenge_result.dart';

@immutable
class H2HInviteAction {
  final String pin;

  H2HInviteAction(this.pin);
}

@immutable
class H2HResendInviteAction {
  final String teamId;

  H2HResendInviteAction(this.teamId);
}

@immutable
class H2HRefreshAction {}

@immutable
class H2HReceiveInviteAction {
  final String teamId;
  final String teamName;

  H2HReceiveInviteAction(this.teamId, this.teamName);
}

@immutable
class H2HInviteAcceptedAction {
  final String teamId;
  final String teamName;
  final bool accepted;

  H2HInviteAcceptedAction(this.teamId, this.teamName, this.accepted);
}

@immutable
class H2HReactInviteAction {
  final String teamId;
  final bool accepted;

  H2HReactInviteAction(this.teamId, this.accepted);
}

@immutable
class H2HSaveOpponentTeamAction {
  final String teamId;
  final String teamName;

  H2HSaveOpponentTeamAction(this.teamId, this.teamName);
}

@immutable
class H2HResultAction{
  final ChallengeResult result;

  H2HResultAction(this.result);
}
