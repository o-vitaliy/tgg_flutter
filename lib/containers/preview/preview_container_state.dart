import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'video/video_preview_state.dart';

@immutable
class PreviewContainerState {
  final bool initialized;
  final String preview;
  final bool isVideo;
  final int screenRotation;
  final int timesPlayed;

  PreviewContainerState({
    @required this.initialized,
    @required this.preview,
    @required this.isVideo,
    @required this.screenRotation,
    @required this.timesPlayed,
  });

  static PreviewContainerState initial() {
    return PreviewContainerState(
      initialized: false,
      screenRotation: 0,
      preview: null,
      isVideo: null,
      timesPlayed: 0,
    );
  }

  PreviewContainerState copyWith({
    Optional<bool> initialized,
    String preview,
    bool isVideo,
    int screenRotation,
    int timesPlayed,
    VideoPreviewState videoPreviewState,
  }) {
    return PreviewContainerState(
      initialized: initialized != null ? initialized.orNull : this.initialized,
      preview: preview ?? this.preview,
      isVideo: isVideo ?? this.isVideo,
      screenRotation: screenRotation ?? this.screenRotation,
      timesPlayed: timesPlayed ?? this.timesPlayed,
    );
  }
}
