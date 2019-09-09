import 'package:tgg/models/blueprint_model.dart';

class Game {
  BlueprintModel blueprint;

  Game.fromJsonMap(Map<String, dynamic> map)
      : blueprint = BlueprintModel.fromJsonMap(map["blueprint"]);
}
