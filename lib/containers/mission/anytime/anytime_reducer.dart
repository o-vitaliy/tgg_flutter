import 'package:moor/moor.dart';
import 'package:redux/redux.dart';

import 'anytime_action.dart';
import 'anytime_state.dart';

final anytimeReducer = combineReducers<AnytimeState>([
  new TypedReducer<AnytimeState, AnytimeLoadedAction>(_loaded),
  new TypedReducer<AnytimeState, AnytimeUpdatePreviewAction>(_updatePreview),
  new TypedReducer<AnytimeState, AnytimeLoadedWaypointAction>(
      _waypointSelected),
  new TypedReducer<AnytimeState, AnytimeChangeListLoadingStateAction>(
      _listLoadingState),
  new TypedReducer<AnytimeState, AnytimeChangeWaipointLoadingStateAction>(
      _waypointLoadingState),
]);

AnytimeState _loaded(AnytimeState state, action) {
  final missions = (action as AnytimeLoadedAction).missions;
  return state.copy(missionList: missions);
}

AnytimeState _updatePreview(AnytimeState state, action) {
  final missions = (action as AnytimeUpdatePreviewAction).missions;
  return state.copy(missionPreviewList: missions);
}

AnytimeState _waypointSelected(AnytimeState state, action) {
  final waypoint = (action as AnytimeLoadedWaypointAction).waypoint;
  return state.copy();
}

AnytimeState _listLoadingState(AnytimeState state, action) {
  final loading = (action as AnytimeChangeListLoadingStateAction).loading;
  return state.copy(listLoading: Value(loading));
}

AnytimeState _waypointLoadingState(AnytimeState state, action) {
  final loading = (action as AnytimeChangeWaipointLoadingStateAction).loading;
  return state.copy(waypointLoading: Value(loading));
}
