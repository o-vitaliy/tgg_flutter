import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]);
}

class LoginFormHasError extends LoginEvent {
  final bool hasError;

  LoginFormHasError({@required this.hasError}) : super([hasError]);
  @override
  List<Object> get props => [hasError];
  @override
  String toString() => 'LoginFormHasError { hasError: $hasError }';
}

class LoginButtonPressed extends LoginEvent {
  final String code;

  LoginButtonPressed({
    @required this.code,
  }) : super([code]);
  @override
  List<Object> get props => [code];
  @override
  String toString() => 'LoginButtonPressed { code: $code }';
}

class Logout extends LoginEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'Logout { }';
}
