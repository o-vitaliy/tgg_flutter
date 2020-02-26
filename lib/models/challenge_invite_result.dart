import 'challenge_invite_status.dart';
import 'team.dart';

class ChallengeInviteResult {
  final ChallengeInviteStatus status;
  final Team team;

  ChallengeInviteResult.fromJsonMap(Map<String, dynamic> map)
      : status = ChallengeInviteStatus.fromJsonMap(map["status"]),
        team = Team.fromJsonMap(map["team"]);
}
