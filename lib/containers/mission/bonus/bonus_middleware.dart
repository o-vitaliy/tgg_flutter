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
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is BonusStartLoadAction) {
      final waypoint =
          store.state.waypointsPassingState.getWaypointForType(CameraMode());

      if (waypoint == null) {
        store.dispatch(BonusChangeListLoadingStateAction(true));

        final teamId = store.state.team.id;
        final missions = store.state.bonus.bonusMissions ??
            await bonusRepo.getMissions(teamId);

        store.dispatch(BonusLoadedAction(missions));
        store.dispatch(BonusChangeListLoadingStateAction(false));

        if (missions != null && missions.isNotEmpty)
          store.dispatch(BonusLoadWaypointAction(missions.first.id));
      }
    }
    next(action);
  };
}

Middleware<AppState> _startMission() {
  return (Store store, action, NextDispatcher next) async {
    if (action is BonusLoadWaypointAction) {
      final teamId = store.state.team.id;
      store.dispatch(BonusChangeWaipointLoadingStateAction(true));
      LoadMissionMiddlewareHelper.getWaypointByMissionId(
              teamId, action.missionId)
          .then((result) {
        store.dispatch(WaypointsSelectCurrentAction(result));
        store.dispatch(BonusChangeWaipointLoadingStateAction(false));
      });
    }
    next(action);
  };
}
