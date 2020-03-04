import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/common/theme/theme_config.dart';
import 'package:tgg/common/theme/themed_buttons.dart';
import 'package:tgg/containers/login/login_actions.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';

class LoginForm extends StatefulWidget {
  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) => store.dispatch(InitLoginAction()),
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          if (controller.text != vm.code) controller.text = vm.code;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: <Widget>[
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "Enter login code:",
                        style: headerTextStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'code',
                          ),
                          onChanged: vm.validateCode,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: getMainTextButton(
                          onPressed: !vm.isLoading && !vm.codeNotEmpty
                              ? () => vm.login(vm.code)
                              : null,
                          label: vm.flavor.get(!vm.isLoading
                              ? "login:login"
                              : "login:logging_in"),
                        ),
                      ),
                      vm.error != null ? Text(vm.error) : const SizedBox(),
                    ],
                  ),
                ),
                vm.isLoading ? LoadingIndicator() : const SizedBox(),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }
}

class _ViewModel {
  final Flavor flavor;
  final String code;
  final bool codeNotEmpty;
  final bool isLoading;
  final String error;

  final Function(String) validateCode;
  final Function(String) login;
  final Function clearError;
  final Function initLogin;

  _ViewModel({
    this.flavor,
    this.code,
    this.codeNotEmpty,
    this.isLoading,
    this.error,
    this.validateCode,
    this.login,
    this.clearError,
    this.initLogin,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final loginState = store.state.loginState;
    final flavor = store.state.flavor;
    final error = loginState.error;
    final errorMessage = error != null
        ? flavor.contains("login:" + error)
            ? flavor.get("login:" + error)
            : error
        : null;
    return _ViewModel(
      flavor: flavor,
      code: loginState.code,
      codeNotEmpty: loginState.codeNotEmpty,
      isLoading: loginState.isLoading,
      error: errorMessage,
      validateCode: (code) => store.dispatch(LoginValidateCodeAction(code)),
      login: (code) => store.dispatch(LoginExecuteAction(code)),
      clearError: (code) => store.dispatch(LoginClearErrorAction()),
      initLogin: () => store.dispatch(InitLoginAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          flavor == other.flavor &&
          code == other.code &&
          codeNotEmpty == other.codeNotEmpty &&
          isLoading == other.isLoading &&
          error == other.error;

  @override
  int get hashCode =>
      flavor.hashCode ^
      code.hashCode ^
      codeNotEmpty.hashCode ^
      isLoading.hashCode ^
      error.hashCode;
}
