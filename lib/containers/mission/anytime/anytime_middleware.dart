import 'package:redux/redux.dart';
import 'package:tgg/containers/mission/base/mission_middleware_helper.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

import 'anytime_action.dart';

List<Middleware<AppState>> createAnytimeMiddleware() {
  return [
    new TypedMiddleware<AppState, AnytimeStartLoadAction>(_loadMissions()),
    new TypedMiddleware<AppState, AnytimeRebuildListAction>(_rebuildMission()),
    new TypedMiddleware<AppState, AnytimeLoadWaypointAction>(_startMission()),
  ];
}

Middleware<AppState> _loadMissions() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AnytimeStartLoadAction) {
      store.dispatch(AnytimeChangeListLoadingStateAction(true));
      final teamId = store.state.team.id;
      final anytime = await anytimeRepo.getMissions(teamId);
      store.dispatch(AnytimeLoadedAction(anytime));
      store.dispatch(AnytimeRebuildListAction());
    }
    next(action);
  };
}

Middleware<AppState> _rebuildMission() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AnytimeRebuildListAction) {
      final teamId = store.state.team.id;
      store.dispatch(AnytimeChangeListLoadingStateAction(true));

      final anytime = store.state.anytime.missionList ?? [];
      final fromWaypoints =
          (await waypointsRepo.getLocalActiveWaypoints(teamId))
              .where((w) => w.mode.name == Mode.anytime)
              .map((w) => Mission.fromWaypoint(w));
      final result = anytime.toList()..addAll(fromWaypoints);
      store.dispatch(AnytimeUpdatePreviewAction(result));
      store.dispatch(AnytimeChangeListLoadingStateAction(false));
    }
    next(action);
  };
}

Middleware<AppState> _startMission() {
  return (Store store, action, NextDispatcher next) async {
    if (action is AnytimeLoadWaypointAction) {
      final teamId = store.state.team.id;
      store.dispatch(AnytimeChangeWaipointLoadingStateAction(true));
      LoadMissionMiddlewareHelper.getWaypointByMissionId(
        teamId,
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
