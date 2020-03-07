import 'package:moor/moor.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/connectivity/connectivity_state.dart';

import 'connectivity_actions.dart';

final connectivityReducer = combineReducers<ConnectivityState>([
  new TypedReducer<ConnectivityState, ConnectivityStateChangedAction>(_changed),
  new TypedReducer<ConnectivityState, ConnectivityChangeSubscriberAction>(
      _changedSubscriberCount),
]);

ConnectivityState _changed(ConnectivityState state, action) {
  final a = (action as ConnectivityStateChangedAction);
  return state.copyWith(connected: Value(a.connected));
}

ConnectivityState _changedSubscriberCount(ConnectivityState state, action) {
  final a = (action as ConnectivityChangeSubscriberAction);
  return state.copyWith(subscribersCount: state.subscribersCount + a.change);
}
