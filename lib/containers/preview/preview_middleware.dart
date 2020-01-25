import 'dart:html';

import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tgg/ui/pages/preview/preview_callbacks.dart';

import 'preview_actions.dart';
import 'preview_state.dart';

List<Middleware<PreviewState>> createPreviewStateMiddleware() {
  return [
    new TypedMiddleware<PreviewState, RetakePreviewAction>(_retakePreview()),
    new TypedMiddleware<PreviewState, SubmitPreviewAction>(_submitPreview()),
  ];
}

Middleware<PreviewState> _retakePreview() {
  return (Store store, action, NextDispatcher next) async {
    if (action is RetakePreviewAction) {
      Navigator.pop(action.context, Retake());
    }
    next(action);
  };
}

Middleware<PreviewState> _submitPreview() {
  return (Store<PreviewState> store, action, NextDispatcher next) async {
    if (action is SubmitPreviewAction) {
      Navigator.pop(action.context, Submit(store.state.preview));
    }
    next(action);
  };
}
