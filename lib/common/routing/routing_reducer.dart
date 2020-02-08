import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/home_actions.dart';
import 'package:tgg/common/routing/routing_state.dart';
import 'package:tgg/models/modes.dart';

final routingReducer = combineReducers<RoutingState>([
  new TypedReducer<RoutingState, ChangeRouteModeAction>(_changeRouteMode),
  new TypedReducer<RoutingState, LogInSuccessful>(_initRouteModeAction),
]);

RoutingState _changeRouteMode(RoutingState state, action) {
  final RouteMode mode = (action as ChangeRouteModeAction).selectedMode;
  return state.copyWith(
    selectedMode: Optional.fromNullable(mode),
  );
}

RoutingState _initRouteModeAction(RoutingState state, action) {
  return RoutingState.initial((action as LogInSuccessful).routing.modes);
}
