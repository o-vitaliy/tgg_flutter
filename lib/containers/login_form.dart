import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/login_actions.dart';
import 'package:tgg/redux_model/app_state.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) => store.dispatch(InitLoginAction()),
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return Form(
              child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'code'),
                onChanged: vm.validateCode,
              ),
              vm.codeError != null ? Text(vm.codeError) : const SizedBox(),
              RaisedButton(
                onPressed: !vm.isLoading ? () => vm.login(vm.code) : null,
                child: Text('Login'),
                textColor: Colors.white,
              ),
              vm.error != null ? Text(vm.error) : const SizedBox(),
              vm.isLoading ? CircularProgressIndicator() : const SizedBox(),
            ],
          ));
        });
  }
}

class _ViewModel {
  final String code;
  final String codeError;
  final bool isLoading;
  final String error;

  final Function(String) validateCode;
  final Function(String) login;
  final Function clearError;
  final Function initLogin;

  _ViewModel({
    this.code,
    this.codeError,
    this.isLoading,
    this.error,
    this.validateCode,
    this.login,
    this.clearError,
    this.initLogin,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final loginState = store.state.loginState;
    return _ViewModel(
      code: loginState.code,
      codeError: loginState.codeError,
      isLoading: loginState.isLoading,
      error: loginState.error,
      validateCode: (code) => store.dispatch(ValidateCodeAction(code)),
      login: (code) => store.dispatch(LoginAction(code)),
      clearError: (code) => store.dispatch(ClearErrorAction()),
      initLogin: () => store.dispatch(InitLoginAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          codeError == other.codeError &&
          isLoading == other.isLoading &&
          error == other.error;

  @override
  int get hashCode =>
      code.hashCode ^ codeError.hashCode ^ isLoading.hashCode ^ error.hashCode;
}
