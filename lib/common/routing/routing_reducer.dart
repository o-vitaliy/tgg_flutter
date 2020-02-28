import 'package:moor/moor.dart';
import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/routing/route_actions.dart';
import 'package:tgg/common/routing/routing_state.dart';
import 'package:tgg/models/modes.dart';

final routingReducer = combineReducers<RoutingState>([
  new TypedReducer<RoutingState, RouteChangeCurrentModeAction>(
      _changeRouteMode),
  new TypedReducer<RoutingState, RouteSaveModesAction>(_saveModesAction),
  new TypedReducer<RoutingState, RouteSaveTimerAction>(_saveTimersAction),
  new TypedReducer<RoutingState, RouteSaveTabAvailability>(
      _saveTimersAvailability),
]);

RoutingState _changeRouteMode(RoutingState state, action) {
  final RouteMode mode = (action as RouteChangeCurrentModeAction).selectedMode;
  return state.copyWith(
    selectedMode: Optional.fromNullable(mode),
  );
}

RoutingState _saveModesAction(RoutingState state, action) {
  return state.copyWith(modes: (action as RouteSaveModesAction).modes);
}

RoutingState _saveTimersAction(RoutingState state, action) {
  return state.copyWith(timers: (action as RouteSaveTimerAction).timers);
}

RoutingState _saveTimersAvailability(RoutingState state, action) {
  return state.copyWith(
      hasAnytimes: Value((action as RouteSaveTabAvailability).hasAnyTime),
      hasBonus: Value((action as RouteSaveTabAvailability).hasBonus));
}
