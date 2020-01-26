import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/preview/video/video_preview_actions.dart';
import 'package:tgg/ui/pages/preview/preview_callbacks.dart';

import 'preview_actions.dart';
import 'preview_state.dart';

List<Middleware<PreviewState>> createPreviewContainerMiddleware() {
  return [
    new TypedMiddleware<PreviewState, InitPreviewAction>(_initPreview()),
    new TypedMiddleware<PreviewState, RetakePreviewAction>(_retakePreview()),
    new TypedMiddleware<PreviewState, SubmitPreviewAction>(_submitPreview()),
  ];
}

Middleware<PreviewState> _initPreview() {
  return (Store store, action, NextDispatcher next) async {
    if (action is InitPreviewAction) {
      if (action.args.isVideo) store.dispatch(InitVideoAction(action.args));
    }
    next(action);
  };
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
      Navigator.pop(action.context, Submit(store.state.containerState.preview));
    }
    next(action);
  };
}
