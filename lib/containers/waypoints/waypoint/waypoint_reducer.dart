import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';

final waypointReducer = combineReducers<WaypointState>([
  new TypedReducer<WaypointState, WaypointInit>(_init),
  new TypedReducer<WaypointState, WaypointSaveAnswer>(_saveAnswer),
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
  final item = state.items
      .where((i) => i.id == a.itemId)
      .first
      .copyWith(answer: a.answer);

  final items = state.items.map((i) {
    if (i.id == a.itemId) {
      return item;
    } else {
      return i;
    }
  }).toList(growable: false);
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
