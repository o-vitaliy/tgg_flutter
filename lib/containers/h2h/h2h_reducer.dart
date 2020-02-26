import 'package:redux/redux.dart';
import 'package:tgg/containers/h2h/h2h_state.dart';

import 'h2h_actions.dart';

final h2hReducer = combineReducers<H2HState>([
  new TypedReducer<H2HState, H2HSaveOpponentTeamAction>(_saveOpponent),
]);

H2HState _saveOpponent(H2HState state, action) {
  final a = action as H2HSaveOpponentTeamAction;
  return state.copy(
    opponentId: a.teamId,
    opponentName: a.teamName,
  );
}
