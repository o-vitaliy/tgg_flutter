import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/bloc/auth/login.dart';
import 'package:tgg/bloc/auth/login_event.dart';
import 'package:tgg/bloc/auth/login_state.dart';
import 'package:tgg/ui/colors.dart';

class LoginForm extends StatefulWidget {
  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _gameCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);
    _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginButtonPressed(code: _gameCodeController.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text('${state.error}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'code'),
                  controller: _gameCodeController,
                  autovalidate: true,
                  validator: (value) {
                    _validateFormValues(_loginBloc);
                    if (value.isEmpty) {
                      return 'Please enter game code';
                    }
                    return null;
                  },
                ),
                RaisedButton(
                  onPressed: state is! LoginLoading && state is! LoginFormError
                      ? _onLoginButtonPressed
                      : null,
                  child: Text('Login'),
                ),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _validateFormValues(LoginBloc bloc) {
    bool hasError = false;
    hasError |= _gameCodeController.text.isEmpty;
    bloc.dispatch(LoginFormHasError(hasError: hasError));
  }

  Widget buildToolbar() {
    return Container(
        height: 56.0,
        alignment: Alignment.centerLeft,
        decoration: new BoxDecoration(
            border: new Border(bottom: BorderSide(color: Color(GREY_LINE)))),
        child: Image.asset("assets/logo-nav-highlight.png"));
  }
}
