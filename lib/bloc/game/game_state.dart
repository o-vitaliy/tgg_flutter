import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tgg/models/models.dart';

abstract class GameState extends Equatable {}

class GameUninitializedState extends GameState {
  GameUninitializedState();

  @override
  List<Object> get props => [];
}

class GameLoadedState extends GameState {
  final Game game;

  GameLoadedState({@required this.game});

  @override
  List<Object> get props => [game];
}
