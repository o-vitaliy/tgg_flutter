import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:tgg/models/models.dart';

import 'game.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Game _game;

  Game get game => _game;

  @override
  Stream<GameState> mapEventToState(GameEvent event) async* {
    if (event is GameLoadedEvent) {
      _game = event.game;
      yield GameLoadedState(game: event.game);
    }
  }

  @override
  GameState get initialState => GameUninitializedState();
}
