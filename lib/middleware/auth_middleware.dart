import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/common/flavor/flavor_actions.dart';
import 'package:tgg/containers/login/login_page.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';

import '../containers/login/login_middleware.dart';

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
        final response = await loginRepo.reLogin();
        if (response != null) {
          doAfterLogin(store, response);
        } else {
          store.dispatch(FlavorLoadDefaultAction());
          store.dispatch(LogInFails("can not relogin"));
          store.dispatch(NavigateToAction.replace(LoginPage.routeName));
        }
      } catch (error) {
        store.dispatch(FlavorLoadDefaultAction());
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
      await loginRepo.logout();
      store.dispatch(NavigateToAction.replace(LoginPage.routeName));
    }
    next(action);
  };
}
