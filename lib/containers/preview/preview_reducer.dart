import 'package:tgg/containers/preview/preview_container_reducer.dart';

import 'preview_state.dart';
import 'video/video_preview_reducer.dart';

PreviewState previewReducer(PreviewState state, action) {
  return PreviewState(
      containerState: previewContainerReducer(state.containerState, action),
      videoPreviewState: videoPreviewReducer(state.videoPreviewState, action));
}
