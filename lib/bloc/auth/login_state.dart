import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]);
}

class LoginInitial extends LoginState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoginInitial';
}

class LoginLoading extends LoginState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoginLoading';
}

class LoginFormError extends LoginState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoginFormError';
}

class LoginFormValid extends LoginState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'LoginFormValid';
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);
  @override
  List<Object> get props => [error];
  @override
  String toString() => 'LoginFailure { error: $error }';
}
