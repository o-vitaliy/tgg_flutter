import 'package:tgg/helpers/expandable_list.dart';
import 'package:tgg/models/challenge.dart';
import 'package:tgg/models/challenge_state.dart';
import 'package:tgg/models/profile.dart';
import 'package:tgg/models/progress.dart';
import 'package:tgg/models/social_info.dart';

class Team {
  String id;
  String name;
  String pin;
  int number;
  int track;
  bool gameRunner;
  bool isArchived;
  String externalUserId;
  Profile profile;
  SocialInfo socialInfo;
  int status;
  List<Object> history;
  List<Challenge> challenges;
  Progress progress;
  int pointsTotal;
  int pointsFromPlay;
  int pointsFromVoting;
  String organizationId;
  String playthroughId;

  Team.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        name = map["name"],
        pin = map["pin"],
        number = map["number"],
        track = map["track"],
        gameRunner = map["game_runner"],
        isArchived = map["is_archived"],
        externalUserId = map["external_user_id"],
        profile = Profile.fromJsonMap(map["profile"]),
        socialInfo = SocialInfo.fromJsonMap(map["social_info"]),
        status = map["status"],
        history = map["history"],
        challenges = Challenge.from(map["challenges"]),
        progress = Progress.fromJsonMap(map["progress"]),
        pointsTotal = map["points_total"],
        pointsFromPlay = map["points_from_play"],
        pointsFromVoting = map["points_from_voting"],
        organizationId = map["organization_id"],
        playthroughId = map["playthrough_id"];

  Challenge getWaitingOpponentToAccept() {
    return challenges?.firstOrNull((c) => c.state == ChallengeState.sent);
  }

  Challenge getReceivedInvite() {
    return challenges?.firstOrNull((c) => c.state == ChallengeState.received);
  }
}
