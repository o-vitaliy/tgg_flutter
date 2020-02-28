import 'dart:async';

import 'package:redux/redux.dart';
import 'package:tgg/common/routing/route_actions.dart';
import 'package:tgg/containers/mission/anytime/anytime_action.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/helpers/expandable_list.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createRoutingMiddleware() {
  return [
    new TypedMiddleware<AppState, RouteLoadAction>(_load()),
    new TypedMiddleware<AppState, RouteUpdateModesAction>(_update()),
    new TypedMiddleware<AppState, AnytimeLoadedAction>(
        _updateAfterAnyTimeChange()),
    new TypedMiddleware<AppState, WaypointsCompletedLoadingAction>(
        _updateAfterWaypointReload()),
  ];
}

Middleware<AppState> _load() {
  return (Store store, action, NextDispatcher next) async {
    if (action is RouteLoadAction) {
      routingRepo.getRouting(action.gameId).then((routing) {
        store.dispatch(RouteUpdateModesAction(routing.modes));
      });
    }
    next(action);
  };
}

Middleware<AppState> _update() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is RouteUpdateModesAction) {
      final startedAt = store.state.playthrough.playthrough.startedAt;
      final routes = action.modes;
      routes.forEach((r) => r.locked = isTimerRunning(startedAt, r.delay));
      final timers = routes
          .where((route) => isTimerRunning(startedAt, route.delay))
          .map((route) => route.delay)
          .map((delay) {
        Timer(Duration(milliseconds: computeDelay(startedAt, delay)),
            () => store.dispatch(RouteUpdateModesAction(routes)));
      });

      store.dispatch(RouteSaveTimerAction(List<Timer>.from(timers)));
      store.dispatch(RouteSaveModesAction(routes));
    }
    next(action);
  };
}

Middleware<AppState> _updateAfterAnyTimeChange() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is AnytimeLoadedAction) {
      final bonus =
          store.state.waypointsPassingState?.getWaypointForType(Mode.camera);
      _missionChange(store, action.missions, bonus);
    }
    next(action);
  };
}

Middleware<AppState> _updateAfterWaypointReload() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointsCompletedLoadingAction) {
      final missions = store.state.anytime?.missions;
      final bonus = action.waypoints.firstOrNull((w) => w.mode == Mode.camera);
      _missionChange(store, missions, bonus);
    }
    next(action);
  };
}

void _missionChange(
  Store<AppState> store,
  List<Mission> missions,
  Waypoint bonusWaypoint,
) {
  final hasAnyTime = missions?.isNotEmpty ?? false;
  final hasBonus = bonusWaypoint != null;

  store.dispatch(RouteSaveTabAvailability(hasAnyTime, hasBonus));
}

int computeDelay(DateTime startedAt, Duration delay) {
  return startedAt.add(delay).millisecondsSinceEpoch -
      DateTime.now().millisecondsSinceEpoch;
}

bool isTimerRunning(DateTime startedAt, Duration delay) {
  if (delay == null) return false;
  return startedAt.add(delay).isAfter(DateTime.now());
}
