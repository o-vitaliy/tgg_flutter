import 'challenge_invite.dart';

class ChallengeInviteAccepted extends ChallengeInvite {
  final bool accepted;

  ChallengeInviteAccepted.fromJsonMap(Map<String, dynamic> map, this.accepted)
      : super.fromJsonMap(map);
}
