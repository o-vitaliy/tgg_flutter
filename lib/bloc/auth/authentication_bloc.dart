import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tgg/bloc/auth/authentication_event.dart';
import 'package:tgg/bloc/auth/authentication_state.dart';
import 'package:tgg/bloc/game/game.dart';
import 'package:tgg/bloc/theme/theme.dart';
import 'package:tgg/data/game_repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final PlaythroughRepo gameRepo;
  final ThemeBloc themeBloc;
  final GameBloc gameBloc;

  AuthenticationBloc({
    @required this.gameRepo,
    @required this.themeBloc,
    @required this.gameBloc,
  }) : assert(gameRepo != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      yield AuthenticationUninitialized();
      final game = await gameRepo.getGame();

      if (game != null) {
        yield AuthenticationAuthenticated();
        gameBloc.dispatch(GameLoadedEvent(game: game));
        updateTheme();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await gameRepo.getGame();
      yield AuthenticationAuthenticated();
      updateTheme();
    }

    if (event is LoggedOut) {
      yield AuthenticationUninitialized();
      sleep(Duration(seconds: 1));
      yield AuthenticationUnauthenticated();
    }
  }

  void updateTheme() {
    themeBloc.dispatch(ThemeChanged(
        theme: ThemeBloc.buildTheme(Colors.green, Colors.green.shade100)));
  }
}
