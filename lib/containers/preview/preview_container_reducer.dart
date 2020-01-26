import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'preview_actions.dart';
import 'preview_container_state.dart';

final previewContainerReducer = combineReducers<PreviewContainerState>([
  new TypedReducer<PreviewContainerState, InitPreviewAction>(_initPreview),
]);

PreviewContainerState _initPreview(PreviewContainerState state, action) {
  final args = (action as InitPreviewAction).args;
  return state.copyWith(
    initialized: Optional.of(true),
    preview: args.preview,
    isVideo: args.isVideo,
    screenRotation: args.screenRotation,
    timesPlayed: 0,
  );
}
