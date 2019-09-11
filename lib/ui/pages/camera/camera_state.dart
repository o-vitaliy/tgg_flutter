import 'package:equatable/equatable.dart';

abstract class CameraState extends Equatable {}

class InitialState extends CameraState {
  @override
  String toString() => 'InitialState';
}

class TakePhotoState extends CameraState {

  @override
  String toString() => 'TakePhotoState';
}

class PhotoWasTakenState extends CameraState{
  final String imagePath;

  PhotoWasTakenState(this.imagePath);

  @override
  String toString() => 'PhotoWasTakenState { imageUrl: $imagePath}';

}

class TakeVideoState extends CameraState {
  String imagePath;

  @override
  String toString() => 'TakeVideoState { imagePath: $imagePath}';
}

class VideoRecordingState extends CameraState {
  String videoPath;

  @override
  String toString() => 'StartVideoRecordingState { imagePath: $videoPath}';
}

class VideoRecordingStoppedState extends CameraState {
  String videoPath;

  @override
  String toString() => 'StopVideoRecordingState { imagePath: $videoPath}';
}

class VideoRecordingPausedState extends CameraState {
  String videoPath;

  @override
  String toString() => 'PauseVideoRecordingState { imagePath: $videoPath}';
}
