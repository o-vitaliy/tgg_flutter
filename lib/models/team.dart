import 'models.dart';

class Team {
  Playthrough playthrough;
  String id;

  Team.fromJsonMap(Map<String, dynamic> map) {
    playthrough = Playthrough.fromJsonMap(map["playthrough"]);
    id = map.containsKey("id") ? map["id"] : "mocked_id";
  }
}
