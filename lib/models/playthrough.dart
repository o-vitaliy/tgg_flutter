import 'models.dart';

class Playthrough {
  Game game;
  String id;
  String name;

  Playthrough.fromJsonMap(Map<String, dynamic> map) {
    game = Game.fromJsonMap(map["game"]);
    id = map["id"];
    name = map["name"];
  }
}
