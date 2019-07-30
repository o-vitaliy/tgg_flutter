import 'package:flutter/material.dart';
import 'package:tgg/blocs/login_bloc.dart';
import 'package:tgg/blocs/login_provider.dart';

import 'colors.dart';

class LogInPage extends StatefulWidget {
  @override
  State createState() => SignInState();
}

class SignInState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = LoginProvider.of(context);
    bloc.loaded.listen(navigateNext);
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[buildToolbar(), buildLoginForm(bloc)],
    )));
  }

  Widget buildToolbar() {
    return Container(
        height: 56.0,
        alignment: Alignment.centerLeft,
        decoration: new BoxDecoration(
            border: new Border(bottom: BorderSide(color: Color(GREY_LINE)))),
        child: Image.asset("assets/logo-nav-highlight.png"));
  }

  Widget buildLoginForm(LoginBloc bloc) {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              buildCodeTextField(bloc),
              buildSubmitButton(bloc)
            ],
          ),
        ));
  }

  Widget buildCodeTextField(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.code,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeCode,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintText: 'Game code',
            errorText: snapshot.error,
          ),
        );
      },
    );
  }

  Widget buildSubmitButton(LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.submitValid,
        builder: (context, snapshot) {
          return SizedBox(
              width: double.infinity,
              child: new RaisedButton(
                onPressed: snapshot.hasData ? bloc.submit : null,
                child: Text('Submit'),
              ));
        });
  }

  void navigateNext(result) {
    if (result)
      Navigator.pushNamed(context, '/main');
    else
      print(result);
  }
}
