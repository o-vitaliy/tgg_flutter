import 'package:redux/redux.dart';
import 'package:tgg/actions/home_actions.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createHomePageMiddleware() {
  /* final logIn = _createLogInMiddleware();*/
  final changeRouteMode = _createChangeRouteModeMiddleware();

  return [
    new TypedMiddleware<AppState, ChangeRouteModeAction>(changeRouteMode),
  ];
}

Middleware<AppState> _createChangeRouteModeMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is ChangeRouteModeAction) {
      //DO nothing
    }
    next(action);
  };
}
