import 'package:flutter/material.dart';
import 'package:tgg/containers/connectivity/connectivity_container.dart';
import 'package:tgg/containers/login/login_form.dart';
import 'package:tgg/ui/keys.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/login';

  LoginPage({Key key = Keys.loginScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Column(
          children: <Widget>[
            ConnectivityContainer(),
            Padding(
              padding: EdgeInsets.all(8),
              child: LoginForm(),
            )
          ],
        ));
  }
}
