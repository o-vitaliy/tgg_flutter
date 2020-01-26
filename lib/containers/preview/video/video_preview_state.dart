import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:video_player/video_player.dart';

@immutable
class VideoPreviewState {
  final VideoPlayerController controller;

  bool get initialized => controller != null;

  final bool isPlaying;

  final int playedTimes;

  bool get firstTimePlayed => playedTimes == 0;

  VideoPreviewState._({
    @required this.controller,
    @required this.playedTimes,
    @required this.isPlaying,
  });

  static VideoPreviewState initial() {
    return VideoPreviewState._(
        playedTimes: 0, controller: null, isPlaying: false);
  }

  VideoPreviewState copyWith({
    Optional<bool> initialized,
    Optional<bool> isPlaying,
    VideoPlayerController controller,
    int playedTimes,
  }) {
    return VideoPreviewState._(
        controller: controller ?? this.controller,
        playedTimes: playedTimes ?? this.playedTimes,
        isPlaying: (controller ?? this.controller)?.value?.isPlaying ?? false);
  }
}
