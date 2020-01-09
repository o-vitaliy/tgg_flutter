import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

class StartInitCameraAction {
  final CaptureArguments args;
  final GlobalKey<CameraContainerState> state;

  StartInitCameraAction(this.args, this.state);
}

class RestartCameraAction{}

class InitCameraAction {
  final CaptureArguments args;
  final GlobalKey<CameraContainerState> state;


  InitCameraAction(this.args, this.state);
}

class InitializedCameraAction {
  final List<CameraDescription> cameras;
  final CameraDescription current;

  InitializedCameraAction(this.cameras, this.current);
}

class InitializedCameraControllerAction {
  final CameraController controller;

  InitializedCameraControllerAction(this.controller);
}

class SaveScreenRotation {
  final int screenRotation;

  SaveScreenRotation(this.screenRotation);
}

class ChangeTorchModeAction {
  final bool toEnable;

  ChangeTorchModeAction(this.toEnable);
}

class SwitchCameraAction {
  final CameraLensDirection lensDirection;

  SwitchCameraAction(this.lensDirection);
}

class TakePhotoAction {}

class StartRecordingAction {}

class PauseRecordingAction {}

class StopRecordingAction {}

class ProcessingAction {
  final bool processing;

  ProcessingAction(this.processing);
}

class ControllerStateChangeAction {
  final bool isRecordingVideo;
  final bool isTakingPhoto;

  ControllerStateChangeAction({this.isRecordingVideo, this.isTakingPhoto});
}

class AddNewFileChangeAction {
  final String path;

  AddNewFileChangeAction(this.path);
}
