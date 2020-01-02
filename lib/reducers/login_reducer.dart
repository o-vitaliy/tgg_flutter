import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/login_actions.dart';
import 'package:tgg/redux_model/login_state.dart';

final loginReducer = combineReducers<LoginState>([
  new TypedReducer<LoginState, ValidateCodeAction>(_validateCode),
  new TypedReducer<LoginState, CodeErrorAction>(_codeError),
  new TypedReducer<LoginState, ChangeLoadingStateAction>(_changeLoadingState),
  new TypedReducer<LoginState, ClearErrorAction>(_clearError),
  new TypedReducer<LoginState, LoginErrorAction>(_loginError),
  new TypedReducer<LoginState, LogOut>(_logOut),
  new TypedReducer<LoginState, InitLoginAction>(_initLogin),
]);

Null _logOut(LoginState response, action) {
  return null;
}

LoginState _validateCode(LoginState state, ValidateCodeAction action) {
  return state.copyWith(code: action.code);
}

LoginState _codeError(LoginState state, CodeErrorAction action) {
  return state.copyWith(codeError: action.error);
}

LoginState _clearError(LoginState state, ClearErrorAction action) {
  return state.copyWith(error: "", codeError: "");
}

LoginState _loginError(LoginState state, LoginErrorAction action) {
  return state.copyWith(error: action.error.toString());
}

LoginState _changeLoadingState(
    LoginState state, ChangeLoadingStateAction action) {
  return state.copyWith(isLoading: action.isLoading);
}

LoginState _initLogin(LoginState state, InitLoginAction action) {
  return LoginState.initial();
}
