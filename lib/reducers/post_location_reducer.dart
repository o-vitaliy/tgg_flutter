import 'dart:async';

import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/post_location_actions.dart';

final postLocationReducer = combineReducers<Timer>([
  new TypedReducer<Timer, PostingLocationStarted>(_started),
  new TypedReducer<Timer, LogOut>(_stopped),
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
