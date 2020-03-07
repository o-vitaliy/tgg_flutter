import 'dart:async';

import 'package:redux/redux.dart';
import 'package:tgg/actions/post_location_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';

const default_delay = Duration(seconds: 60);

List<Middleware<AppState>> createPostingLocationMiddleware() {
  final startPosting = _createStartPostingMiddleware();
  final stopPosting = _createStopPostingMiddleware();
  final post = _createPostMiddleware();

  return [
    new TypedMiddleware<AppState, StartPostingLocation>(startPosting),
    new TypedMiddleware<AppState, StopPostingLocation>(stopPosting),
    new TypedMiddleware<AppState, PostLocation>(post)
  ];
}

Middleware<AppState> _createStartPostingMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is StartPostingLocation) {
      final timer =
          Timer.periodic(default_delay, (t) => store.dispatch(PostLocation()));
      store.dispatch(PostingLocationStarted(timer));
      store.dispatch(PostLocation());
    }
    next(action);
  };
}

Middleware<AppState> _createStopPostingMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    return (Store store, action, NextDispatcher next) async {
      if (action is StopPostingLocation) {
        action.timer.cancel();
        store.dispatch(PostingLocationStopped());
      }
      next(action);
    };
  };
}

Middleware<AppState> _createPostMiddleware() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is PostLocation) {
      locationRepo.sendLocation();
    }
    next(action);
  };
}
