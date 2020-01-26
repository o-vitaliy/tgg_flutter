import 'dart:io';

import 'package:redux/redux.dart';
import 'package:video_player/video_player.dart';

import '../preview_state.dart';
import 'video_preview_actions.dart';

List<Middleware<PreviewState>> createVideoPreviewMiddleware() {
  return [
    new TypedMiddleware<PreviewState, InitVideoAction>(_initVideo()),
    new TypedMiddleware<PreviewState, PlayVideoAction>(_playVideo()),
    new TypedMiddleware<PreviewState, StopVideoAction>(_stopVideo()),
  ];
}

Middleware<PreviewState> _initVideo() {
  return (Store<PreviewState> store, action, NextDispatcher next) async {
    if (action is InitVideoAction) {
      store.dispatch(StartInitializingVideoAction());
      final String path = action.args.preview;
      final VideoPlayerController controller =
          VideoPlayerController.file(File(path));
      await controller.initialize();
      store.dispatch(InitializedVideoAction(controller));
    }
    next(action);
  };
}

Middleware<PreviewState> _playVideo() {
  return (Store<PreviewState> store, action, NextDispatcher next) async {
    if (action is PlayVideoAction) {
      store.state.videoPreviewState.controller.addListener(() async {
        store.dispatch(VideoPlayingStateChangedAction());
      });
      final controller = store.state.videoPreviewState.controller;
      await controller.seekTo(Duration(milliseconds: 0));
      await controller.play();

      store.dispatch(IncrementPlayCountAction());
    }
    next(action);
  };
}

Middleware<PreviewState> _stopVideo() {
  return (Store<PreviewState> store, action, NextDispatcher next) async {
    if (action is StopVideoAction) {
      await store.state.videoPreviewState.controller.pause();
    }
    next(action);
  };
}
