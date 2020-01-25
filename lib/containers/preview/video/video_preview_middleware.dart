import 'dart:io';

import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';

import '../preview_state.dart';
import 'video_preview_actions.dart';

List<Middleware<PreviewState>> createPreviewStateMiddleware() {
  return [
    new TypedMiddleware<PreviewState, InitVideoAction>(_initVideo()),
    new TypedMiddleware<PreviewState, PlayVideoAction>(_playVideo()),
    new TypedMiddleware<PreviewState, StopVideoAction>(_stopVideo()),
  ];
}

Middleware<PreviewState> _initVideo() {
  return (Store<PreviewState> store, action, NextDispatcher next) async {
    if (action is PlayVideoAction) {
      final String path = store.state.preview;
      final VideoPlayerController controller =
          VideoPlayerController.file(File(path));
      await controller.initialize();

    }
    next(action);
  };
}

Middleware<PreviewState> _playVideo() {
  return (Store<PreviewState> store, action, NextDispatcher next) async {
    if (action is PlayVideoAction) {
      await store.state.videoPreviewState.controller.play();
    }
    next(action);
  };
}

Middleware<PreviewState> _stopVideo() {
  return (Store<PreviewState> store, action, NextDispatcher next) async {
    if (action is PlayVideoAction) {
      await store.state.videoPreviewState.controller.pause();
    }
    next(action);
  };
}
