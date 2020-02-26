import 'package:flutter/material.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';

class DialogHelper {
  static BuildContext findContext() {
   return NavigatorHolder.navigatorKey.currentState.overlay.context;
  }
}
