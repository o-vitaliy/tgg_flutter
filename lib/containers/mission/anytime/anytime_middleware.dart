import 'package:redux/redux.dart';
import 'package:tgg/containers/mission/base/mission_middleware_helper.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

import 'anytime_action.dart';

List<Middleware<AppState>> createAnytimeMiddleware() {
  return [
    new TypedMiddleware<AppState, AnytimeStartLoadAction>(_loadMissions()),
    new TypedMiddleware<AppState, AnytimeLoadWaypointAction>(_startMission()),
  ];
}

Middleware<AppState> _loadMissions() {
  return (Store store, action, NextDispatcher next) async {
    if (action is AnytimeStartLoadAction) {
      store.dispatch(AnytimeChangeListLoadingStateAction(true));
      LoadMissionMiddlewareHelper.loadMission(
        store,
        anytimeRepo,
        action.waypoints,
        Mode.anytime,
      ).then((result) {
        store.dispatch(AnytimeLoadedAction(result));
      }).then(
          (_) => store.dispatch(AnytimeChangeListLoadingStateAction(false)));
    }
    next(action);
  };
}

Middleware<AppState> _startMission() {
  return (Store store, action, NextDispatcher next) async {
    if (action is AnytimeLoadWaypointAction) {
      store.dispatch(AnytimeChangeWaipointLoadingStateAction(true));
      LoadMissionMiddlewareHelper.getWaypointByMissionId(
        store,
        action.missionId,
      ).then((result) {
        store.dispatch(WaypointsSelectCurrentAction(result));
        return result;
      }).then((result) {
        store.dispatch(AnytimeLoadedWaypointAction(result));
        store.dispatch(AnytimeChangeWaipointLoadingStateAction(false));
      });
    }
    next(action);
  };
}
