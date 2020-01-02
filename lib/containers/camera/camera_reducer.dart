import 'package:redux/redux.dart';

import 'camera_actions.dart';
import 'camera_state.dart';

final cameraReducer = combineReducers<CameraState>([
  new TypedReducer<CameraState, InitCameraAction>(_initCamera),
  new TypedReducer<CameraState, InitializedCameraAction>(
      _initCameraDescription),
  new TypedReducer<CameraState, InitializedCameraControllerAction>(
      _initCameraController),
  new TypedReducer<CameraState, SaveScreenRotation>(_saveCameraRotation),
  new TypedReducer<CameraState, ProcessingAction>(_processing),
  new TypedReducer<CameraState, AddNewFileChangeAction>(_addNewFile),
  new TypedReducer<CameraState, ControllerStateChangeAction>(
      _controllerStateChanged),
]);

CameraState _initCamera(CameraState state, action) {
  return CameraState(
      captureArgs: (action as InitCameraAction).args,
      timerDuration: Duration(seconds: 30),
      files: List<String>(),
      processingResult: false,
      isRecordingVideo: false,
      isTakingPhoto: false);
}

CameraState _initCameraDescription(CameraState state, action) {
  return state.copyWith(
    cameras: (action as InitializedCameraAction).cameras,
    currentCamera: (action as InitializedCameraAction).current,
  );
}

CameraState _initCameraController(CameraState state, action) {
  return state.copyWith(
    controller: (action as InitializedCameraControllerAction).controller,
  );
}

CameraState _saveCameraRotation(CameraState state, action) {
  return state.copyWith(
    screenRotation: (action as SaveScreenRotation).screenRotation,
  );
}

CameraState _processing(CameraState state, action) {
  return state.copyWith(
    processingResult: (action as ProcessingAction).processing,
  );
}

CameraState _addNewFile(CameraState state, action) {
  final files = List<String>.from(state.files)
    ..add((action as AddNewFileChangeAction).path);
  return state.copyWith(
    files: files,
  );
}

CameraState _controllerStateChanged(CameraState state, action) {
  return state.copyWith(
    isRecordingVideo: (action as ControllerStateChangeAction).isRecordingVideo,
    isTakingPhoto: (action as ControllerStateChangeAction).isTakingPhoto,
  );
}
