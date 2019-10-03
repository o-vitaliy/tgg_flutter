import 'models.dart';

class Team {
  Playthrough playthrough;

  Team.fromJsonMap(Map<String, dynamic> map) {
    playthrough = Playthrough.fromJsonMap(map["playthrough"]);
  }
}
