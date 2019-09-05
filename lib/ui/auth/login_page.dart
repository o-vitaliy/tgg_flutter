import 'package:flutter/material.dart';
import 'package:tgg/data/repositories.dart';

import 'login_form.dart';

class LoginPage extends StatelessWidget {
  final GameRepo gameRepository;

  LoginPage({Key key, @required this.gameRepository})
      : assert(gameRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: LoginForm()
    );
  }
}
