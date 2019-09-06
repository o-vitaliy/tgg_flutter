import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tgg/models/game/game.dart';

abstract class GameState extends Equatable {}

class GameUninitializedState extends GameState {
  GameUninitializedState();
}
class GameLoadedState extends GameState {
  final Game game;

  GameLoadedState({@required this.game});
}
