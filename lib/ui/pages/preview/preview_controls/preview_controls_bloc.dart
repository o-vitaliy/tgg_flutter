import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:video_player/video_player.dart';

import './bloc.dart';

class PreviewControlsBloc extends Bloc<PreviewControlsEvent, PreviewState> {
  @override
  PreviewState get initialState => InitialPreviewControlsState();

  VideoPlayerController _controller;

  @override
  Stream<PreviewState> mapEventToState(
    PreviewControlsEvent event,
  ) async* {
    if (event is InitControlsEvent) {
      await _controller?.dispose();
      _controller = VideoPlayerController.file(File(event.videoPath));
      await _controller.setLooping(false);
      await _controller.initialize();
      yield StoppedPreviewState(true, _controller);
    } else if (event is PlayPreviewEvent) {
      await _controller.play();
      yield PlayingPreviewState(_controller);
    } else if (event is StopPreviewEvent) {
      await _controller.pause();
      yield StoppedPreviewState(false, _controller);
    } else if (event is ResetPreviewEvent) {
      await _controller.pause();
      await _controller.seekTo(Duration());
      yield StoppedPreviewState(false, _controller);
    }
  }
}
