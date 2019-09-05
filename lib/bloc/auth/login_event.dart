import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginFormHasError extends LoginEvent {
  final bool hasError;

  LoginFormHasError({@required this.hasError}) : super([hasError]);

  @override
  String toString() => 'LoginFormHasError { hasError: $hasError }';
}

class LoginButtonPressed extends LoginEvent {
  final String code;

  LoginButtonPressed({
    @required this.code,
  }) : super([code]);

  @override
  String toString() => 'LoginButtonPressed { code: $code }';
}

class Logout extends LoginEvent {
  @override
  String toString() => 'Logout { }';
}
