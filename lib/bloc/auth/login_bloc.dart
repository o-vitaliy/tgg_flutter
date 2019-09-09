import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tgg/bloc/auth/authentication_bloc.dart';
import 'package:tgg/bloc/auth/authentication_event.dart';
import 'package:tgg/bloc/auth/login_event.dart';
import 'package:tgg/bloc/auth/login_state.dart';
import 'package:tgg/bloc/game/game.dart';
import 'package:tgg/data/game_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GameRepo gameRepo;
  final AuthenticationBloc authenticationBloc;
  final GameBloc gameBloc;

  LoginBloc({
    @required this.gameRepo,
    @required this.authenticationBloc,
    @required this.gameBloc,
  })  : assert(gameRepo != null),
        assert(authenticationBloc != null),
        assert(gameBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginFormHasError) {
      yield event.hasError ? LoginFormError() : LoginFormValid();
    }
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final game = await gameRepo.loadGame(code: event.code);

        authenticationBloc.dispatch(LoggedIn(game));
        gameBloc.dispatch(GameLoadedEvent(game: game));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is Logout) {
      await gameRepo.removeGame();

      authenticationBloc.dispatch(LoggedOut());
      yield LoginInitial();
    }
  }
}
