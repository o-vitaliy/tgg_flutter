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
  final int screenRotation;

  PhotoWasTakenState(this.imagePath, this.screenRotation);

  @override
  List<Object> get props => [imagePath, screenRotation];

  @override
  String toString() {
    return 'PhotoWasTakenState{imagePath: $imagePath, screenRotation: $screenRotation}';
  }
}

class VideoWasTakenState extends CameraState {
  final String videoPath;
  final int screenRotation;

  VideoWasTakenState(this.videoPath, this.screenRotation);

  @override
  List<Object> get props => [videoPath, screenRotation];

  @override
  String toString() {
    return 'VideoWasTakenState{videoPath: $videoPath, screenRotation: $screenRotation}';
  }
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
