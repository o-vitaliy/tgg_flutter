class LoginValidateCodeAction {
  final String code;

  LoginValidateCodeAction(this.code);
}

class LoginCodeErrorAction {
  final bool codeNotEmpty;

  LoginCodeErrorAction(this.codeNotEmpty);
}

class LoginChangeLoadingStateAction {
  final bool isLoading;

  LoginChangeLoadingStateAction(this.isLoading);
}

class LoginClearErrorAction {}

class LoginExecuteAction {
  final String code;

  LoginExecuteAction(this.code);
}

class LoginErrorAction {
  final dynamic error;

  LoginErrorAction(this.error);
}

class InitLoginAction{}

class LoginReloginWithCodeAction{
  final String code;

  LoginReloginWithCodeAction(this.code);
}
