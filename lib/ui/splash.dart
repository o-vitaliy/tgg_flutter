import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/colors.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(ReLogIn());
    return Container(
        color: Color(ORANGE),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icon180.png'),
            ),
          ),
        ));
  }
}
