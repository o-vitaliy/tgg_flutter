import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';

final waypointReducer = combineReducers<WaypointState>([
  new TypedReducer<WaypointState, WaypointInit>(_init),
  new TypedReducer<WaypointState, WaypointSaveAnswer>(_saveAnswer),
  new TypedReducer<WaypointState, WaypointShowError>(_showError),
  new TypedReducer<WaypointState, WaypointHintShown>(_showHint),
  new TypedReducer<WaypointState, WaypointRemoveAction>(_removeAction),
  new TypedReducer<WaypointState, WaypointIncrementAttemptAction>(
      _waypointIncrementAttemptAction),
]);

WaypointState _init(WaypointState state, action) {
  return WaypointState(
      waypoint: (action as WaypointInit).waypoint,
      items: (action as WaypointInit).items,
      hintsUsed: 0,
      hint: null,
      attemptsUsed: 0);
}

WaypointState _saveAnswer(WaypointState state, action) {
  final a = action as WaypointSaveAnswer;
  final item = state.items.where((i) => i.submission == a.submission).first;
  final items = state.items.where((i) => i.submission != a.submission).toList()
    ..add(item.copyWith(answer: a.answer, error: Optional.absent()));
  return state.copyWith(items: items);
}

WaypointState _showError(WaypointState state, action) {
  final a = action as WaypointShowError;
  final item = state.items.where((i) => i.submission == a.submission).first;
  final items = state.items.where((i) => i.submission != a.submission).toList()
    ..add(item.copyWith(error: Optional.fromNullable(a.error)));
  return state.copyWith(items: items);
}

WaypointState _showHint(WaypointState state, action) {
  final a = action as WaypointHintShown;
  return state.copyWith(hint: a.hint, hintsUsed: a.usedCount);
}

Null _removeAction(WaypointState state, action) {
  return null;
}

WaypointState _waypointIncrementAttemptAction(WaypointState state, action) {
  return state.copyWith(attemptsUsed: state.attemptsUsed + 1);
}
