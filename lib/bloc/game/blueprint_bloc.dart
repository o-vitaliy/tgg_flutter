import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tgg/models/game/game.dart';

import 'blueprint.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Game game;

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is GameLoadedEvent) {
      game = event.game;
      yield GameLoadedState(game: event.game);
    }
  }

  @override
  GameState get initialState => GameUninitializedState();
}
