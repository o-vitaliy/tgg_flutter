import 'package:flutter/material.dart';

import 'colors.dart';

class LogInPage extends StatefulWidget {
  @override
  State createState() => SignInState();
}

class SignInState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: <Widget>[buildToolbar(), buildLoginForm()],
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

  Widget buildLoginForm() {
    return Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              SizedBox(
                  width: double.infinity,
                  child: new RaisedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false
                      // otherwise.
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, display a Snackbar.
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Processing Data')));
                      }
                    },
                    child: Text('Submit'),
                  )),
            ],
          ),
        ));
  }
}
