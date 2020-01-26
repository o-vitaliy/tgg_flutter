import 'package:meta/meta.dart';
import 'package:tgg/containers/preview/preview_container_state.dart';

import 'video/video_preview_state.dart';

@immutable
class PreviewState {
  final PreviewContainerState containerState;
  final VideoPreviewState videoPreviewState;

  PreviewState({
    @required this.containerState,
    @required this.videoPreviewState,
  });

  static PreviewState initial() {
    return PreviewState(
      containerState: PreviewContainerState.initial(),
      videoPreviewState: null,
    );
  }
}
