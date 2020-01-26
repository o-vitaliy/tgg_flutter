import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';

final waypointReducer = combineReducers<WaypointState>([
  new TypedReducer<WaypointState, WaypointInit>(_init),
  new TypedReducer<WaypointState, WaypointSaveAnswer>(_saveAnswer),
  new TypedReducer<WaypointState, WaypointShowError>(_showError),
  new TypedReducer<WaypointState, WaypointRemoveAction>(_removeAction),
]);

WaypointState _init(WaypointState state, action) {
  return WaypointState(
    waypoint: (action as WaypointInit).waypoint,
    items: (action as WaypointInit).items,
  );
}

WaypointState _saveAnswer(WaypointState state, action) {
  final a = action as WaypointSaveAnswer;
  final item = state.items.where((i) => i.submission == a.submission).first;
  final items = state.items.where((i) => i.submission != a.submission).toList()
    ..add(item.copyWith(
        answer: a.answer, media: a.media, error: Optional.absent()));
  return state.copyWith(items: items);
}

WaypointState _showError(WaypointState state, action) {
  final a = action as WaypointShowError;
  final item = state.items.where((i) => i.submission == a.submission).first;
  final items = state.items.where((i) => i.submission != a.submission).toList()
    ..add(item.copyWith(error: Optional.fromNullable(a.error)));
  return state.copyWith(items: items);
}

Null _removeAction(WaypointState state, action) {
  return null;
}
