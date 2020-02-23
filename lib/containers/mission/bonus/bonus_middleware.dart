import 'package:redux/redux.dart';
import 'package:tgg/containers/mission/base/mission_middleware_helper.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

import 'bonus_action.dart';

List<Middleware<AppState>> createBonusMiddleware() {
  return [
    new TypedMiddleware<AppState, BonusStartLoadAction>(_loadMissions()),
    new TypedMiddleware<AppState, BonusLoadWaypointAction>(_startMission()),
  ];
}

Middleware<AppState> _loadMissions() {
  return (Store store, action, NextDispatcher next) async {
    if (action is BonusStartLoadAction) {
      store.dispatch(BonusChangeListLoadingStateAction(false));
      LoadMissionMiddlewareHelper.loadMission(
        store,
        bonusRepo,
        action.waypoints,
        Mode.camera,
      ).then((result) {
        store.dispatch(BonusLoadedAction(result));
        store.dispatch(BonusChangeListLoadingStateAction(false));
        return result;
      }).then((result) {
        if (result != null && result.isNotEmpty)
          store.dispatch(BonusLoadWaypointAction(result.first.id));
      });
    }
    next(action);
  };
}

Middleware<AppState> _startMission() {
  return (Store store, action, NextDispatcher next) async {
    if (action is BonusLoadWaypointAction) {
      store.dispatch(BonusChangeWaipointLoadingStateAction(true));
      LoadMissionMiddlewareHelper.getWaypointByMissionId(
              store, action.missionId)
          .then((result) {
        store.dispatch(WaypointsSelectCurrentAction(result));
        store.dispatch(BonusChangeWaipointLoadingStateAction(false));
      });
    }
    next(action);
  };
}
