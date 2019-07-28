import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';

import 'colors.dart';

class LogInPage extends StatefulWidget {
  @override
  State createState() => SignInState();
}

class SignInState extends State<LogInPage> {

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        buildToolbar(),
      ],
    );
  }

  Widget buildToolbar() {
    return Container(
        height: 56.0,
        alignment: Alignment.center,
        decoration: new BoxDecoration(
            border: new Border(bottom: BorderSide(color: Color(GREY_LINE)))),
        child: Image.asset("assets/logo-nav-highlight.png")
    );
  }
}
