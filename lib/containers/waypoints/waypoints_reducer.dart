import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/containers/waypoints/waypoints_state.dart';

final waypointsReducer = combineReducers<WaypointsState>([
  new TypedReducer<WaypointsState, WaypointsStartedLoadingAction>(_startLoad),
  new TypedReducer<WaypointsState, WaypointsCompletedLoadingAction>(_loaded),
  new TypedReducer<WaypointsState, LogOut>(_logout),
]);

WaypointsState _startLoad(WaypointsState state, action) {
  return state.copyWith(isLoading: true);
}

WaypointsState _loaded(WaypointsState state, action) {
  return state.copyWith(
    isLoading: false,
    activeWaypoints: (action as WaypointsCompletedLoadingAction).waypoints,
  );
}

WaypointsState _logout(WaypointsState state, action) {
  return WaypointsState.initial();
}
