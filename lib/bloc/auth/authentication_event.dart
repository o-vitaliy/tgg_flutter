import 'package:equatable/equatable.dart';
import 'package:tgg/models/models.dart';

abstract class AuthenticationEvent extends Equatable {
  AuthenticationEvent([List props = const []]) : super(props);
}

class AppStarted extends AuthenticationEvent {
  @override
  String toString() => 'AppStarted';
}

class LoggedIn extends AuthenticationEvent {
  final Game game;

  LoggedIn(this.game);

  @override
  String toString() => 'LoggedIn {game: $game}';
}


class LoggedOut extends AuthenticationEvent{
  @override
  String toString() => 'LoggedOut';
}