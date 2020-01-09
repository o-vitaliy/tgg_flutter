import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createWaypointsMiddleware() {
  final loadWaypoint = _createLoadWaypointMiddleware();

  return [
    new TypedMiddleware<AppState, WaypointsStartLoadAction>(loadWaypoint),
  ];
}

Middleware<AppState> _createLoadWaypointMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is WaypointsStartLoadAction) {
      store.dispatch(WaypointsStartedLoadingAction());
      final waypoints = await waypointsRepo.getActiveWaypoints();
      store.dispatch(WaypointsSelectCurrentAction(
          waypoints.length > 0 ? waypoints.first : null));
      store.dispatch(WaypointsCompletedLoadingAction(waypoints));
    }
    next(action);
  };
}
