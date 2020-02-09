import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import 'dialog_action.dart';

class DialogMiddleware<T> implements MiddlewareClass<T> {
  @override
  void call(Store<T> store, action, next) async {
    if (action is DialogAction) {
      showDialog(
        context: action.context,
        builder: action.builder,
      );
    }
    next(action);
  }
}
