import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PreviewState extends Equatable {
  PreviewState([List props = const <dynamic>[]]);
}

class UnitializedPreviewState extends PreviewState {
  @override
  List<Object> get props => [];
}

class ImagePreviewState extends PreviewState {
  final String link;

  ImagePreviewState(this.link);

  @override
  List<Object> get props => [link];

  @override
  String toString() => 'ImagePreviewState { link: $link}';
}

class VideoPreviewState extends PreviewState {
  final String link;

  VideoPreviewState(this.link);

  @override
  List<Object> get props => [link];

  @override
  String toString() => 'VideoPreviewState { link: $link}';
}
