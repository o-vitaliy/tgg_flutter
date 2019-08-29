import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tgg/bloc/auth/authentication_bloc.dart';
import 'package:tgg/bloc/auth/authentication_event.dart';
import 'package:tgg/bloc/auth/login_event.dart';
import 'package:tgg/bloc/auth/login_state.dart';
import 'package:tgg/data/game_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GameRepo gameRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.gameRepository,
    @required this.authenticationBloc,
  })  : assert(gameRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final game = await gameRepository.loadGame(code: event.code);

        authenticationBloc.dispatch(LoggedIn(game));
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
