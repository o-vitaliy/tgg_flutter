import 'package:equatable/equatable.dart';
import 'package:tgg/models/game/game_info.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final GameInfo game;

  LoggedIn(this.game);

  @override
  String toString() => 'LoggedIn {game: $game}';
}