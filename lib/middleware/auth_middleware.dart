import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/home_actions.dart';
import 'package:tgg/actions/theme_actions.dart';
import 'package:tgg/data/game_repository.dart';
import 'package:tgg/data/login_repo.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/auth/login_page.dart';
import 'package:tgg/ui/home.dart';

List<Middleware<AppState>> createAuthMiddleware() {
 /* final logIn = _createLogInMiddleware();*/
  final reLogIn = _createReLogInMiddleware();
  final logOut = _createLogOutMiddleware();

  return [
    /*new TypedMiddleware<AppState, LogIn>(logIn),*/
    new TypedMiddleware<AppState, ReLogIn>(reLogIn),
    new TypedMiddleware<AppState, LogOut>(logOut)
  ];
}
/*
Middleware<AppState> _createLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is LogIn) {
      final gameCode = action.gameCode;
      if (gameCode == null || gameCode.length < 3) {
        store.dispatch(LogInFails("code too short"));
      } else {
        try {
          final response = await logInRepo.login(code: gameCode);
          store.dispatch(new UpdateThemeAction(Colors.green, Colors.green.shade100));
          store.dispatch(new LogInSuccessful(loginResponse: response));
          store.dispatch(NavigateToAction.replace(HomePage.routeName));
        } catch (error) {
          store.dispatch(LogInFails(error));
        }
      }
    }
    next(action);
  };
}*/

Middleware<AppState> _createReLogInMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is ReLogIn) {
      try {
        final response = await logInRepo.reLogin();
        if (response != null) {
          final playthrough = await playthroughRepo.getPlaythrough();
          store.dispatch(new UpdateThemeAction(Colors.green, Colors.green.shade100));
          store.dispatch(LogInSuccessful(loginResponse: response, playthrough: playthrough));
          store.dispatch(NavigateToAction.replace(HomePage.routeName));
        } else {
          store.dispatch(LogInFails("can not relogin"));
          store.dispatch(NavigateToAction.replace(LoginPage.routeName));
        }
      } catch (error) {
        store.dispatch(LogInFails(error));
        store.dispatch(NavigateToAction.replace(LoginPage.routeName));
      }
    }
    next(action);
  };
}

Middleware<AppState> _createLogOutMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is LogOut) {
      await logInRepo.removeGame();
      store.dispatch(new LogOut());
    }
    next(action);
  };
}
