import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tgg/data/game_repository.dart';
import 'package:tgg/ui/auth/authentication_event.dart';
import 'package:tgg/ui/auth/authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GameRepository gameRepository;

  AuthenticationBloc({@required this.gameRepository})
      : assert(gameRepository != null);

  @override
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      final game = await gameRepository.getGame();

      if (game != null) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await gameRepository.getGame();
      yield AuthenticationAuthenticated();
    }
  }
}
