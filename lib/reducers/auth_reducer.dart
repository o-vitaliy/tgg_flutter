import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/models/login_response.dart';

final authReducer = combineReducers<LoginResponse>([
  new TypedReducer<LoginResponse, LogInSuccessful>(_logIn),
  new TypedReducer<LoginResponse, LogOut>(_logOut),
]);

LoginResponse _logIn(LoginResponse response, action) {
  return (action as LogInSuccessful).loginResponse;
}

// This will just replace the user slice of state with null.
Null _logOut(LoginResponse response, action) {
  return null;
}
