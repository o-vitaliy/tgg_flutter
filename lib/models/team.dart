import 'package:tgg/models/challenges.dart';
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
  Challenges challenges;
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
        challenges = Challenges.fromJsonMap(map["challenges"]),
        progress = Progress.fromJsonMap(map["progress"]),
        pointsTotal = map["points_total"],
        pointsFromPlay = map["points_from_play"],
        pointsFromVoting = map["points_from_voting"],
        organizationId = map["organization_id"],
        playthroughId = map["playthrough_id"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['pin'] = pin;
    data['number'] = number;
    data['track'] = track;
    data['game_runner'] = gameRunner;
    data['is_archived'] = isArchived;
    data['external_user_id'] = externalUserId;
    data['profile'] = profile == null ? null : profile.toJson();
    data['social_info'] = socialInfo == null ? null : socialInfo.toJson();
    data['status'] = status;
    data['history'] = history;
    data['challenges'] = challenges == null ? null : challenges.toJson();
    data['progress'] = progress == null ? null : progress.toJson();
    data['points_total'] = pointsTotal;
    data['points_from_play'] = pointsFromPlay;
    data['points_from_voting'] = pointsFromVoting;
    data['organization_id'] = organizationId;
    data['playthrough_id'] = playthroughId;
    return data;
  }
}
