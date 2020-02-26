class ChallengeInviteStatus {
  final bool isOk;
  final String result;
  final String teamName;

  ChallengeInviteStatus.fromJsonMap(Map<String, dynamic> map)
      : isOk = map["ok"],
        result = map["result"],
        teamName = map["team_name"];
}
