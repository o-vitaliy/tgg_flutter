import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/login_actions.dart';
import 'package:tgg/actions/theme_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/home.dart';

const codeErrorMessage = "code should have atleast 3 characters";

List<Middleware<AppState>> createLoginMiddleware() {
  /* final logIn = _createLogInMiddleware();*/
  final validateCode = _createValidateCodeMiddleware();
  final logIn = _createLogInMiddleware();

  return [
    new TypedMiddleware<AppState, ValidateCodeAction>(validateCode),
    new TypedMiddleware<AppState, LoginAction>(logIn)
  ];
}

Middleware<AppState> _createValidateCodeMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is ValidateCodeAction) {
      final code = action.code;
      if (code == null || code.length < 3) {
        store.dispatch(CodeErrorAction(codeErrorMessage));
      } else {
        store.dispatch(CodeErrorAction(""));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is LoginAction) {
      store.dispatch(ClearErrorAction());
      store.dispatch(ChangeLoadingStateAction(true));
      try {
        final code = action.code;
        final response = await loginRepo.login(code: code);
        final playthroughId = response.team.playthroughId;
        final playthrough = await playthroughRepo.getPlaythrough(playthroughId);
        store.dispatch(
            new UpdateThemeAction(Colors.green, Colors.green.shade100));
        store.dispatch(new LogInSuccessful(
            loginResponse: response, playthrough: playthrough));
        store.dispatch(NavigateToAction.replace(HomePage.routeName));
      } catch (error) {
        print(error);
        store.dispatch(LoginErrorAction(error?.message ?? "Unexpected error"));
      }
      store.dispatch(ChangeLoadingStateAction(false));
    }
    next(action);
  };
}
