import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/models/models.dart';

final playthoughReducer = combineReducers<Playthrough>([
  new TypedReducer<Playthrough, LogInSuccessful>(_logIn),
  new TypedReducer<Playthrough, LogOut>(_logOut),
]);

Playthrough _logIn(Playthrough response, action) {
  return (action as LogInSuccessful).playthrough;
}

// This will just replace the user slice of state with null.
Null _logOut(Playthrough response, action) {
  return null;
}
