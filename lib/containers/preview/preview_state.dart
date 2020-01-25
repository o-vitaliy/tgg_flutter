import 'package:meta/meta.dart';
import 'package:quiver/core.dart';

import 'video/video_preview_state.dart';

@immutable
class PreviewState {
  final bool initialized;
  final String preview;
  final bool isVideo;
  final int screenRotation;
  final int firstTime;

  final VideoPreviewState videoPreviewState;

  PreviewState({
    @required this.initialized,
    @required this.preview,
    @required this.isVideo,
    @required this.screenRotation,
    @required this.videoPreviewState,
    @required this.firstTime,
  });

  static PreviewState initial() {
    return PreviewState(initialized: false);
  }

  PreviewState copyWith({
    Optional<bool> initialized,
    String preview,
    bool isVideo,
    int screenRotation,
  }) {
    return PreviewState(
      initialized: initialized != null ? initialized.orNull : this.initialized,
      preview: preview ?? this.preview,
      isVideo: isVideo ?? this.isVideo,
      screenRotation: screenRotation ?? this.screenRotation,
    );
  }
}
