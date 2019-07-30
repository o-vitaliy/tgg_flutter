import 'game_info.dart';

class GameResponse{
  List<GameInfo> games;

  GameResponse.fromJsonMap(Map<String, dynamic> map)
      : games = List.of(map["flavors"].map((it) => GameInfo.fromJsonMap(it)));
}
