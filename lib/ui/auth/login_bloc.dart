import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tgg/data/game_repository.dart';
import 'package:tgg/ui/auth/authentication_bloc.dart';
import 'package:tgg/ui/auth/authentication_event.dart';
import 'package:tgg/ui/auth/login_event.dart';
import 'package:tgg/ui/auth/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GameRepository gameRepository;
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
        await gameRepository.loadGame(code: event.code);

        authenticationBloc.dispatch(LoggedIn());
        yield LoginInitial();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
