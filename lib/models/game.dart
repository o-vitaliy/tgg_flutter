import 'package:tgg/models/blueprint_model.dart';

class Game {
  final BlueprintModel blueprint;
  final String id;

  Game.fromJsonMap(Map<String, dynamic> map)
      : blueprint = BlueprintModel.fromJsonMap(map["blueprint"]),
        id = map["id"];
}
