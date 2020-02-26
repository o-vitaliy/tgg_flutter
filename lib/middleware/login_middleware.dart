import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/login_actions.dart';
import 'package:tgg/common/blueprint/blueprint_actions.dart';
import 'package:tgg/common/flavor/flavor_actions.dart';
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
        doAfterLogin(store, response);
      } catch (error) {
        print(error);
        store.dispatch(LoginErrorAction(error?.message ?? "Unexpected error"));
      }
      store.dispatch(ChangeLoadingStateAction(false));
    }
    next(action);
  };
}

void doAfterLogin(final Store store, final LoginResponse response) async {
  final playthroughId = response.team.playthroughId;
  final playthrough = await playthroughRepo.getPlaythrough(playthroughId);
  final routing = await routingRepo.getRouting(playthrough.game.id);

  store.dispatch(UpdateBlueprint(playthrough.game.blueprint));
  store.dispatch(new LogInSuccessful(
    loginResponse: response,
    playthrough: playthrough,
    routing: routing,
  ));
  store.dispatch(NavigateToAction.replace(HomePage.routeName));

  staticRepo.getFlavor(playthrough.game.blueprint.id).then((v) {
    store.dispatch(UpdateFlavorAction(v));
  }).then((_) {
    store.dispatch(WaypointsStartLoadAction());
  }).then((_) async {
    await h2hRepo.registerFcm(response.team.id);
  });
}
