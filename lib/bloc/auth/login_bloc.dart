import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tgg/bloc/auth/authentication_bloc.dart';
import 'package:tgg/bloc/auth/authentication_event.dart';
import 'package:tgg/bloc/auth/login_event.dart';
import 'package:tgg/bloc/auth/login_state.dart';
import 'package:tgg/bloc/game/game.dart';
import 'package:tgg/data/game_repository.dart';
import 'package:tgg/data/login_repo.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepo loginRepo;
  final PlaythroughRepo gameRepo;
  final AuthenticationBloc authenticationBloc;
  final GameBloc gameBloc;

  LoginBloc({
    @required this.loginRepo,
    @required this.gameRepo,
    @required this.authenticationBloc,
    @required this.gameBloc,
  })  : assert(loginRepo != null),
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
        await loginRepo.login(code: event.code);
        final game = await gameRepo.getGame();
        authenticationBloc.dispatch(LoggedIn(game));
        gameBloc.dispatch(GameLoadedEvent(game: game));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }

    if (event is Logout) {
      loginRepo.removeGame();

      authenticationBloc.dispatch(LoggedOut());
      yield LoginInitial();
    }
  }
}
