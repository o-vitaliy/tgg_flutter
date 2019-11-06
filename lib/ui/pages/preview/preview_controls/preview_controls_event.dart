import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PreviewControlsEvent extends Equatable {
  PreviewControlsEvent([List props = const <dynamic>[]]) : super();
}

class InitControlsEvent extends PreviewControlsEvent {
  final String videoPath;
  final int screenRotation;

  InitControlsEvent(this.videoPath, this.screenRotation);

  @override
  List<Object> get props => [videoPath, screenRotation];
}

class PlayPreviewEvent extends PreviewControlsEvent {
  @override
  List<Object> get props => [];
}

class StopPreviewEvent extends PreviewControlsEvent {
  @override
  List<Object> get props => [];
}

class ResetPreviewEvent extends PreviewControlsEvent {
  @override
  List<Object> get props => [];
}

class DisposePreviewEvent extends PreviewControlsEvent {
  @override
  List<Object> get props => [];
}
