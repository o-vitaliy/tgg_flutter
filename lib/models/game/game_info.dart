import 'package:tgg/models/game.dart';

class GameInfo {
  List<Game> games;

  GameInfo.fromJsonMap(Map<String, dynamic> map) {
    final m1 = map["games"];
    final m2 = m1.map((it) => Game.fromJsonMap(it));
    print(m2);
    games = List<Game>.from(m2);
  }
}
