import 'challenge_invite.dart';

class ChallengeResult extends ChallengeInvite {
  final int points;
  final bool successful;
  final bool agreed;

  ChallengeResult.fromJsonMap(Map<String, dynamic> map)
      : points = map["points"],
        successful = map["successful"],
        agreed = map["agreed"],
        super.fromJsonMap(map);
}
