import 'package:quiver/core.dart';
import 'package:redux/redux.dart';

import 'preview_actions.dart';
import 'preview_state.dart';

final previewReducer = combineReducers<PreviewState>([
  new TypedReducer<PreviewState, InitPreviewAction>(_initPreview),
]);

PreviewState _initPreview(PreviewState state, action) {
  final args = (action as InitPreviewAction).args;
  return state.copyWith(
    initialized: Optional.of(true),
    preview: args.preview,
    isVideo: args.isVideo,
    screenRotation: args.screenRotation,
  );
}
