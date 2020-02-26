class ChallengeInvite {
  final String teamId;
  final String teamName;
  final String modeName;

  ChallengeInvite.fromJsonMap(Map<String, dynamic> map)
      : teamId = map["team_id"],
        teamName = map["team_name"],
        modeName = map["mode_name"];
}
