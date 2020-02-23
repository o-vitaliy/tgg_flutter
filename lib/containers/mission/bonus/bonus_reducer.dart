import 'package:moor/moor.dart';
import 'package:redux/redux.dart';

import 'bonus_action.dart';
import 'bonus_state.dart';

final bonusReducer = combineReducers<BonusState>([
  new TypedReducer<BonusState, BonusLoadedAction>(_loaded),
  new TypedReducer<BonusState, BonusLoadedWaypointAction>(_waypointSelected),
  new TypedReducer<BonusState, BonusChangeListLoadingStateAction>(
      _listLoadingState),
  new TypedReducer<BonusState, BonusChangeWaipointLoadingStateAction>(
      _waypointLoadingState),
]);

BonusState _loaded(BonusState state, action) {
  final missions = (action as BonusLoadedAction).missions;
  return state.copy(missions: missions);
}

BonusState _waypointSelected(BonusState state, action) {
  final waypoint = (action as BonusLoadedWaypointAction).waypoint;
  return state.copy();
}

BonusState _listLoadingState(BonusState state, action) {
  final loading = (action as BonusChangeListLoadingStateAction).loading;
  return state.copy(listLoading: Value(loading));
}

BonusState _waypointLoadingState(BonusState state, action) {
  final loading = (action as BonusChangeWaipointLoadingStateAction).loading;
  return state.copy(waypointLoading: Value(loading));
}
