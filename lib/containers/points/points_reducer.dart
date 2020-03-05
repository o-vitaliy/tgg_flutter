import 'package:redux/redux.dart';
import 'package:tgg/containers/points/points_actions.dart';
import 'package:tgg/containers/points/points_state.dart';

final pointsReducer = combineReducers<PointsState>([
  new TypedReducer<PointsState, PointsUpdatedAction>(_updated),
]);

PointsState _updated(PointsState state, action) {
  final a = (action as PointsUpdatedAction);
  return state.copyWith(value: a.points);
}
