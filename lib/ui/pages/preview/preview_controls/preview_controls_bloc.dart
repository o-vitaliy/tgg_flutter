import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:video_player/video_player.dart';

import './bloc.dart';

class PreviewControlsBloc extends Bloc<PreviewControlsEvent, PreviewState> {
  @override
  PreviewState get initialState => InitialPreviewControlsState();

  VideoPlayerController _controller;
  int _screenRotation;

  @override
  Stream<PreviewState> mapEventToState(
    PreviewControlsEvent event,
  ) async* {
    if (event is InitControlsEvent) {
      await _controller?.dispose();
      _controller = VideoPlayerController.file(File(event.videoPath));
      _screenRotation = event.screenRotation;
      await _controller.setLooping(false);
      await _controller.initialize();
      yield StoppedPreviewState(true, _controller, _screenRotation);
    } else if (event is PlayPreviewEvent) {
      await _controller.play();
      yield PlayingPreviewState(_controller, _screenRotation);
    } else if (event is StopPreviewEvent) {
      await _controller.pause();
      yield StoppedPreviewState(false, _controller, _screenRotation);
    } else if (event is ResetPreviewEvent) {
      await _controller.pause();
      await _controller.seekTo(Duration());
      yield StoppedPreviewState(false, _controller, _screenRotation);
    } else if (event is DisposePreviewEvent) {
      _controller = null;
      await _controller?.dispose();
    }
  }

  @override
  Stream<PreviewState> transformStates(Stream<PreviewState> states) {
    return (states as Observable<PreviewState>).delay(Duration(seconds: 1));
  }
}
