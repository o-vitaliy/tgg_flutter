import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/theme_actions.dart';
import 'package:tgg/helpers/theme_helper.dart';

final themeDataReducer = combineReducers<ThemeData>([
  new TypedReducer<ThemeData, UpdateThemeAction>(_changeTheme),
  new TypedReducer<ThemeData, DefaultThemeAction>(_defaultTheme),
]);

ThemeData _changeTheme(ThemeData response, action) {
  if (action is UpdateThemeAction) {
    return buildTheme(action.primarySwatch, action.disabledColor);
  } else {
    return response;
  }
}

ThemeData _defaultTheme(ThemeData response, action) {
  return getDefaultTheme();
}
