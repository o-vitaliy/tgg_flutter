import 'package:flutter/material.dart';

import 'login_bloc.dart';

class LoginProvider extends InheritedWidget {
  final bloc = LoginBloc();

  LoginProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static LoginBloc of(BuildContext context) {
    //* What it does is through the "of" function, it looks through the context of a widget from the deepest in the widget tree
    //* and it keeps travelling up to each widget's parent's context until it finds a "Provider" widget
    //* and performs the type conversion to Provider through "as Provider" and then access the Provider's bloc instance variable
    return (context.inheritFromWidgetOfExactType(LoginProvider) as LoginProvider).bloc;
  }
}
