import 'package:flutter/material.dart';

@immutable
class LoginState {
  final bool isLoading;
  final String error;
  final String code;
  final String codeError;

  LoginState({@required this.isLoading, this.error, this.code, this.codeError});

  LoginState copyWith({
    bool isLoading,
    String error,
    String code,
    String codeError,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      code: code ?? this.code,
      codeError: codeError ?? this.codeError,
    );
  }

  factory LoginState.initial() {
    return LoginState(isLoading: false);
  }
}
