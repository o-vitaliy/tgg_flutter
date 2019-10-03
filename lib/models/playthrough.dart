import 'models.dart';

class Playthrough {
  Game game;

  Playthrough.fromJsonMap(Map<String, dynamic> map) {
    game = Game.fromJsonMap(map["game"]);
  }
}
