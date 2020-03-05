import 'package:redux/redux.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';

import '../waypoints/waypoint/waypoint_calculation.dart';
import 'points_actions.dart';

const _remoteId = "remote_update";

List<Middleware<AppState>> createPointsMiddleware() {
  return [
    new TypedMiddleware<AppState, PointsCalculateAction>(_calculate()),
    new TypedMiddleware<AppState, PointsRemoteUpdateAction>(_remoteUpdate()),
    new TypedMiddleware<AppState, PointsWaypointSubmittedAction>(_submitted()),
    new TypedMiddleware<AppState, PointsAddChallengeAction>(_addChallange()),
  ];
}

Middleware<AppState> _calculate() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is PointsCalculateAction) {
      final value = await daoPoints.getSum();
      store.dispatch(PointsUpdatedAction(value));
    }
    next(action);
  };
}

Middleware<AppState> _remoteUpdate() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is PointsRemoteUpdateAction) {
      await daoPoints.deleteAll();
      await daoPoints.insert(_remoteId, action.points);
      store.dispatch(PointsCalculateAction());
    }
    next(action);
  };
}

Middleware<AppState> _submitted() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is PointsWaypointSubmittedAction) {
      final state = action.waypointState;
      if (state.waypoint.step.scoring == 0) {
        final waypointId = state.waypoint.id;
        final points = WaypointCalculation.points(state);
        await daoPoints.insert(waypointId, points);
        store.dispatch(PointsCalculateAction());
      }
    }
    next(action);
  };
}

Middleware<AppState> _addChallange() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is PointsAddChallengeAction) {
      await daoPoints.insert(action.waypointId, action.points);
      store.dispatch(PointsCalculateAction());
    }
    next(action);
  };
}
