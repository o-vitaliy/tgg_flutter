import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/models/team.dart';

import 'team_actions.dart';

final teamReducer = combineReducers<Team>([
  new TypedReducer<Team, LogInSuccessful>(_logIn),
  new TypedReducer<Team, TeamStartUpdateAction>(_update),
  new TypedReducer<Team, LogOut>(_logOut),
]);

Team _logIn(Team response, action) {
  return (action as LogInSuccessful).loginResponse.team;
}

Team _update(Team response, action) {
  return (action as TeamStartUpdateAction).team;
}

// This will just replace the user slice of state with null.
Null _logOut(Team response, action) {
  return null;
}
