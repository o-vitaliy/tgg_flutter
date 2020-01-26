import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/preview/video/video_preview_state.dart';

import 'video_preview_actions.dart';

final videoPreviewReducer = combineReducers<VideoPreviewState>([
  new TypedReducer<VideoPreviewState, StartInitializingVideoAction>(
      _startInitVideoPreview),
  new TypedReducer<VideoPreviewState, InitializedVideoAction>(
      _initVideoPreview),
  new TypedReducer<VideoPreviewState, VideoPlayingStateChangedAction>(
      _videoChangedPreview),
  new TypedReducer<VideoPreviewState, IncrementPlayCountAction>(
      _incrementPlayCount),
]);

VideoPreviewState _startInitVideoPreview(VideoPreviewState state, action) {
  return VideoPreviewState.initial();
}

VideoPreviewState _initVideoPreview(VideoPreviewState state, action) {
  return state.copyWith(
    initialized: Optional.of(true),
    controller: (action as InitializedVideoAction).controller,
    playedTimes: 0,
  );
}

VideoPreviewState _videoChangedPreview(VideoPreviewState state, action) {
  return state.copyWith();
}

VideoPreviewState _incrementPlayCount(VideoPreviewState state, action) {
  return state.copyWith(playedTimes: state.playedTimes + 1);
}
