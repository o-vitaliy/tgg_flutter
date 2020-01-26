import 'package:meta/meta.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';
import 'package:video_player/video_player.dart';

@immutable
class InitVideoAction {
  final ImagePreviewArguments args;

  InitVideoAction(this.args);
}

@immutable
class PlayVideoAction {}

@immutable
class StopVideoAction {}

@immutable
class StartInitializingVideoAction {}

@immutable
class InitializedVideoAction {
  final VideoPlayerController controller;

  InitializedVideoAction(this.controller);
}

@immutable
class VideoPlayingStateChangedAction {
  VideoPlayingStateChangedAction();
}

@immutable
class IncrementPlayCountAction {
  IncrementPlayCountAction();
}
