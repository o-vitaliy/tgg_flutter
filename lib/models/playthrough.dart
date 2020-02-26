import 'package:tgg/models/playthrough_status.dart';

import 'models.dart';

class Playthrough {
  Game game;
  String id;
  String name;
  DateTime startedAt;
  PlaythroughStatus status;

  Playthrough.fromJsonMap(Map<String, dynamic> map) {
    game = Game.fromJsonMap(map["game"]);
    id = map["id"];
    name = map["name"];
    startedAt = map["started_at"] != null
        ? DateTime.parse(map["started_at"])
        : DateTime(1970);
    status = PlaythroughStatusHelper.getFromInt(map["status"]);
  }
}
