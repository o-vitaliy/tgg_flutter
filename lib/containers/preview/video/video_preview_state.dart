import 'package:meta/meta.dart';
import 'package:quiver/core.dart';
import 'package:video_player/video_player.dart';

@immutable
class VideoPreviewState {
  final VideoPlayerController controller;

  bool get initialized => controller != null;

  bool get isPlaying => initialized && controller.value.isPlaying;

  final int playedTimes;

  bool get firstTimePlayed => playedTimes >= 1;

  VideoPreviewState({
    @required this.controller,
    @required this.playedTimes,
  });

  static VideoPreviewState initial() {
    return VideoPreviewState(playedTimes: 0);
  }

  VideoPreviewState copyWith({
    Optional<bool> initialized,
    VideoPlayerController controller,
    int playedTimes,
  }) {
    return VideoPreviewState(
      controller: controller ?? this.controller,
      playedTimes: playedTimes ?? this.playedTimes,
    );
  }
}
