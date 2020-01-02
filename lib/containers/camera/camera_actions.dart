import 'package:camera/camera.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

class StartInitCameraAction {
  final CaptureArguments args;

  StartInitCameraAction(this.args);
}

class InitCameraAction {
  final CaptureArguments args;

  InitCameraAction(this.args);
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
