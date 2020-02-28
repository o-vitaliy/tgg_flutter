import 'package:flutter/material.dart';
import 'package:moor/moor.dart';

@immutable
class LoginState {
  final bool isLoading;
  final String error;
  final String code;
  final bool codeNotEmpty;

  LoginState(
      {@required this.isLoading, this.error, this.code, this.codeNotEmpty});

  LoginState copyWith({
    bool isLoading,
    Value<String> error,
    String code,
    bool codeNotEmpty,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error != null ? error.value : this.error,
      code: code ?? this.code,
      codeNotEmpty: codeNotEmpty ?? this.codeNotEmpty,
    );
  }

  factory LoginState.initial() {
    return LoginState(isLoading: false, codeNotEmpty: false);
  }
}
