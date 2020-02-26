import 'challenge_state.dart';

class Challenge {
  final String teamId;
  final String teamName;
  final ChallengeState state;

  Challenge.fromMap(Map<String, dynamic> map)
      : teamId = map["team"],
        teamName = map["team_name"],
        state = ChallengeStateHelper.fromString(map["state"]);

  static List<Challenge> from(map) {
    if (map is List) {
      return List<Challenge>.from(map.map((c) => Challenge.fromMap(c)));
    } else {
      return List<Challenge>();
    }
  }
}
