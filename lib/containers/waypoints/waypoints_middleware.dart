import 'package:redux/redux.dart';
import 'package:tgg/containers/mission/anytime/anytime_action.dart';
import 'package:tgg/containers/mission/bonus/bonus_action.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
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
      waypointsRepo.getActiveWaypoints().then((waypoints) {
        final selected = waypoints.firstWhere((w) => w.mode == Mode.main,
            orElse: () => null);
        if (selected != null) {
          store.dispatch(WaypointsSelectCurrentAction(selected));
        }
        store.dispatch(WaypointsCompletedLoadingAction(waypoints));
        return waypoints;
      }).then((waypoints) {
        store.dispatch(AnytimeStartLoadAction(waypoints));
        store.dispatch(BonusStartLoadAction(waypoints));
      });
    }
    next(action);
  };
}
