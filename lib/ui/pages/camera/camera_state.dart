import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {}

class InitialState extends CameraState {
  @override
  String toString() => 'InitialState';

  @override
  List<Object> get props => [];
}

class PhotoWasTakenState extends CameraState {
  final String imagePath;

  PhotoWasTakenState(this.imagePath);
  @override
  List<Object> get props => [imagePath];
  @override
  String toString() => 'PhotoWasTakenState { imageUrl: $imagePath}';
}

class VideoWasTakenState extends CameraState {
  final String videoPath;

  VideoWasTakenState(this.videoPath);
  @override
  List<Object> get props => [videoPath];
  @override
  String toString() => 'VideoWasTakenState { videoPath: $videoPath}';
}

class VideoRecordingState extends CameraState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'StartVideoRecordingState {}';
}

class VideoRecordingPausedState extends CameraState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'PauseVideoRecordingState {}';
}
