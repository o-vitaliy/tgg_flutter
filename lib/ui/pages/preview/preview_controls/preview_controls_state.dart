import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:video_player/video_player.dart';

@immutable
abstract class PreviewState extends Equatable {
  PreviewState([List props = const <dynamic>[]]) : super();
}

@immutable
abstract class VideoPlayerPreviewState extends PreviewState {
  final VideoPlayerController controller;
  final int screenRotation;

  VideoPlayerPreviewState(this.controller, this.screenRotation)
      : super([controller, screenRotation]);
}

class InitialPreviewControlsState extends PreviewState {
  @override
  List<Object> get props => [];
}

class PlayingPreviewState extends VideoPlayerPreviewState {
  PlayingPreviewState(VideoPlayerController controller, int screenRotation)
      : super(controller, screenRotation);

  @override
  List<Object> get props => [];

  @override
  String toString() {
    return 'PlayingPreviewState{controller: $controller}';
  }
}

class StoppedPreviewState extends VideoPlayerPreviewState {
  final bool firstTime;

  StoppedPreviewState(
      this.firstTime, VideoPlayerController controller, int screenRotation)
      : super(controller, screenRotation);

  @override
  List<Object> get props => [firstTime];

  @override
  String toString() {
    return 'StoppedPreviewState{firstTime: $firstTime, controller: $controller}';
  }
}
