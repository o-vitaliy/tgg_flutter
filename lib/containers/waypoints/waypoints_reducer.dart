import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/containers/waypoints/waypoints_state.dart';

final waypointsReducer = combineReducers<WaypointsState>([
  new TypedReducer<WaypointsState, WaypointsStartedLoadingAction>(_startLoad),
  new TypedReducer<WaypointsState, WaypointsCompletedLoadingAction>(_loaded),
  new TypedReducer<WaypointsState, WaypointsSelectCurrentAction>(
      _selectPlaying),
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

WaypointsState _selectPlaying(WaypointsState state, action) {
  return state.copyWith(
    currentWaypoint: (action as WaypointsSelectCurrentAction).waypoint,
  );
}
