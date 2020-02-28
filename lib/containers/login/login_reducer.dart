import 'package:moor/moor.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/containers/login/login_actions.dart';
import 'package:tgg/containers/login/login_state.dart';

final loginReducer = combineReducers<LoginState>([
  new TypedReducer<LoginState, LoginValidateCodeAction>(_validateCode),
  new TypedReducer<LoginState, LoginCodeErrorAction>(_codeError),
  new TypedReducer<LoginState, LoginChangeLoadingStateAction>(
      _changeLoadingState),
  new TypedReducer<LoginState, LoginClearErrorAction>(_clearError),
  new TypedReducer<LoginState, LoginErrorAction>(_loginError),
  new TypedReducer<LoginState, LogOut>(_logOut),
  new TypedReducer<LoginState, InitLoginAction>(_initLogin),
]);

Null _logOut(LoginState response, action) {
  return null;
}

LoginState _validateCode(LoginState state, LoginValidateCodeAction action) {
  return state.copyWith(code: action.code);
}

LoginState _codeError(LoginState state, LoginCodeErrorAction action) {
  return state.copyWith(codeNotEmpty: action.codeNotEmpty);
}

LoginState _clearError(LoginState state, LoginClearErrorAction action) {
  return state.copyWith(error: Value.absent());
}

LoginState _loginError(LoginState state, LoginErrorAction action) {
  return state.copyWith(error: Value(action.error));
}

LoginState _changeLoadingState(
    LoginState state, LoginChangeLoadingStateAction action) {
  return state.copyWith(isLoading: action.isLoading);
}

LoginState _initLogin(LoginState state, InitLoginAction action) {
  return LoginState.initial();
}
