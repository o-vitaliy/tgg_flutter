import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/common/blueprint/blueprint_actions.dart';
import 'package:tgg/common/flavor/flavor_actions.dart';
import 'package:tgg/common/routing/route_actions.dart';
import 'package:tgg/containers/login/login_actions.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/login_response.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/home.dart';

const codeErrorMessage = "code should have atleast 3 characters";

List<Middleware<AppState>> createLoginMiddleware() {
  /* final logIn = _createLogInMiddleware();*/
  final validateCode = _createValidateCodeMiddleware();
  final logIn = _createLogInMiddleware();

  return [
    new TypedMiddleware<AppState, LoginValidateCodeAction>(validateCode),
    new TypedMiddleware<AppState, LoginExecuteAction>(logIn)
  ];
}

Middleware<AppState> _createValidateCodeMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is LoginValidateCodeAction) {
      final code = action.code;
      checkCodeValid(store, code);
    }
    next(action);
  };
}

Middleware<AppState> _createLogInMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is LoginExecuteAction) {
      final code = action.code;
      checkCodeValid(store, code);
      store.dispatch(LoginChangeLoadingStateAction(true));
      try {
        final response = await loginRepo.login(code: code);
        doAfterLogin(store, response);
      } catch (error) {
        print(error);
        final message = (error is ArgumentError) ? error?.message : null;
        store.dispatch(LoginErrorAction(message ?? "error"));
      }
      store.dispatch(LoginChangeLoadingStateAction(false));
    }
    next(action);
  };
}

void checkCodeValid(Store<AppState> store, String code) {
  store.dispatch(LoginCodeErrorAction(code == null || code.length == 0));
  store.dispatch(LoginClearErrorAction());
}

void doAfterLogin(
    final Store<AppState> store, final LoginResponse response) async {
  final playthroughId = response.team.playthroughId;
  final playthrough = await playthroughRepo.getPlaythrough(playthroughId);

  store.dispatch(
      new LogInSuccessful(loginResponse: response, playthrough: playthrough));

  store.dispatch(UpdateBlueprint(playthrough.game.blueprint));
  store.dispatch(RouteLoadAction(playthrough.game.id, playthrough.startedAt));
  store.dispatch(NavigateToAction.replace(HomePage.routeName));
  store.dispatch(
      FlavorLoadAction(playthrough.game.blueprint.id, playthrough.game.id));
  store.dispatch(WaypointsStartLoadAction());
  await h2hRepo.registerFcm(response.team.id).then((_) {});
}
