import 'dart:async';

import 'package:redux/redux.dart';
import 'package:tgg/actions/post_location_actions.dart';
import 'package:tgg/actions/theme_actions.dart';

/*
ThemeData themeDataReducer(ThemeData current, action) {
  if (action is UpdateThemeAction) {
    return buildTheme(action.primarySwatch, action.disabledColor);
  } else if (action is DefaultThemeAction) {
    return defaultTheme;
  } else {
    return current;
  }
}
*/

final postLocationReducer = combineReducers<Timer>([
  new TypedReducer<Timer, PostingLocationStarted>(_started),
  new TypedReducer<Timer, DefaultThemeAction>(_stopped),
]);

Timer _started(Timer response, action) {
  if (action is PostingLocationStarted) {
    return action.timer;
  } else {
    return response;
  }
}

Null _stopped(Timer response, action) {
  return null;
}
