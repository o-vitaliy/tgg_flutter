import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/theme_actions.dart';
import 'package:tgg/redux_model/app_state.dart';

class GreenThemeButton extends StatelessWidget {
  GreenThemeButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector<AppState, VoidCallback>(
      converter: (Store<AppState> store) {
        return () {
          store.dispatch(new UpdateThemeAction(Colors.green, Colors.green.shade100));
        };
      },
      builder: (BuildContext context, VoidCallback doAction) {
        return new MaterialButton(
          onPressed: doAction,
          child: Text("green"),
        );
      },
    );
  }
}