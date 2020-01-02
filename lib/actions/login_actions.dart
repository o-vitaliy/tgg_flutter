class ValidateCodeAction {
  final String code;

  ValidateCodeAction(this.code);
}

class CodeErrorAction {
  final String error;

  CodeErrorAction(this.error);
}

class ChangeLoadingStateAction {
  final bool isLoading;

  ChangeLoadingStateAction(this.isLoading);
}

class ClearErrorAction {}

class LoginAction {
  final String code;

  LoginAction(this.code);
}

class LoginErrorAction {
  final dynamic error;

  LoginErrorAction(this.error);
}

class InitLoginAction{}
