import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';

final waypointReducer = combineReducers<WaypointState>([
  new TypedReducer<WaypointState, WaypointInit>(_init),
  new TypedReducer<WaypointState, WaypointRemoveAction>(_remove),
  new TypedReducer<WaypointState, WaypointSaveAnswer>(_saveAnswer),
  new TypedReducer<WaypointState, WaypointHintShown>(_showHint),
  new TypedReducer<WaypointState, WaypointIncrementAttemptAction>(
      _waypointIncrementAttemptAction),
  new TypedReducer<WaypointState, LogOut>(_logout),
]);

WaypointState _init(WaypointState state, action) {
  final a = action as WaypointInit;
  return state
    ..put(
        a.waypointId,
        WaypointItemState(
          waypoint: (action as WaypointInit).waypoint,
          items: (action as WaypointInit).items,
          hintsUsed: 0,
          hint: null,
          attemptsUsed: 0,
        ));
}

WaypointState _remove(WaypointState state, action) {
  final a = action as WaypointRemoveAction;
  return state..remove(a.waypointId);
}

WaypointState _saveAnswer(WaypointState state, action) {
  final a = action as WaypointSaveAnswer;
  final ws = state[a.waypointId];
  final item =
      ws.items.where((i) => i.id == a.itemId).first.copyWith(answer: a.answer);

  final items = ws.items.map((i) {
    if (i.id == a.itemId) {
      return item;
    } else {
      return i;
    }
  }).toList(growable: false);
  return state..put(a.waypointId, ws.copyWith(items: items));
}

WaypointState _showHint(WaypointState state, action) {
  final a = action as WaypointHintShown;
  final ws = state[a.waypointId];
  return state
    ..put(a.waypointId, ws.copyWith(hint: a.hint, hintsUsed: a.usedCount));
}

WaypointState _waypointIncrementAttemptAction(WaypointState state, action) {
  final a = action as WaypointIncrementAttemptAction;
  final ws = state[a.waypointId];

  return state
    ..put(a.waypointId, ws.copyWith(attemptsUsed: ws.attemptsUsed + 1));
}

WaypointState _logout(WaypointState state, action) {
  return WaypointState.initial();
}
