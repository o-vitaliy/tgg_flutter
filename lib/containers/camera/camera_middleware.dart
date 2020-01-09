import 'package:camera/camera.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/camera/camera_actions.dart';
import 'package:tgg/containers/camera/camera_state.dart';
import 'package:tgg/data/video_data_repository.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/pages/camera/camera_bloc.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';
import 'package:tgg/ui/pages/preview/preview.dart';

List<Middleware<AppState>> createCameraMiddleware() {
  final initCamera = _createInitCameraMiddleware();
  final restartCamera = _createRestartCameraMiddleware();
  final switchCamera = _createSwitchChangeMiddleware();
  final startRecording = _createStartRecordingMiddleware();
  final stopRecording = _createStopRecordingMiddleware();
  final pauseRecording = _createPauseRecordingMiddleware();
  final takePhoto = _createTakePhotoMiddleware();

  return [
    new TypedMiddleware<AppState, StartInitCameraAction>(initCamera),
    new TypedMiddleware<AppState, RestartCameraAction>(restartCamera),
    new TypedMiddleware<AppState, SwitchCameraAction>(switchCamera),
    new TypedMiddleware<AppState, TakePhotoAction>(takePhoto),
    new TypedMiddleware<AppState, StartRecordingAction>(startRecording),
    new TypedMiddleware<AppState, StopRecordingAction>(stopRecording),
    new TypedMiddleware<AppState, PauseRecordingAction>(pauseRecording),
  ];
}

Middleware<AppState> _createInitCameraMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is StartInitCameraAction) {
      store.dispatch(InitCameraAction(action.args, action.state));
      final cameras = await availableCameras();
      final current = cameras.first;
      store.dispatch(InitializedCameraAction(cameras, current));
      _initializeNewController(store, current);
    }
    next(action);
  };
}

Middleware<AppState> _createRestartCameraMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is RestartCameraAction) {
      final CameraState cameraState = store.state.cameraState;

      final cameras = cameraState.cameras;
      final currentCamera = cameraState.currentCamera;
      store
          .dispatch(InitCameraAction(cameraState.captureArgs, cameraState.key));
      store.dispatch(InitializedCameraAction(cameras, currentCamera));
      _initializeNewController(store, currentCamera);
    }
    next(action);
  };
}

Middleware<AppState> _createSwitchChangeMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is SwitchCameraAction) {
      final state = store.state as AppState;
      await state.cameraState.controller?.dispose();
      final current = state.cameraState.cameras
          .firstWhere((c) => c.lensDirection == action.lensDirection);
      _initializeNewController(store, current);
    }
    next(action);
  };
}

Middleware<AppState> _createStartRecordingMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is StartRecordingAction) {
      final CameraState state = store.state.cameraState;
      final path = await getVideoTmpFile();
      store.dispatch(AddNewFileChangeAction(path));
      await state.controller.startVideoRecording(path);
    }
    next(action);
  };
}

Middleware<AppState> _createPauseRecordingMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is PauseRecordingAction) {
      final CameraState state = store.state.cameraState;
      await state.controller.stopVideoRecording();
    }
    next(action);
  };
}

Middleware<AppState> _createStopRecordingMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is StopRecordingAction) {
      store.dispatch(ProcessingAction(true));
      final CameraState state = store.state.cameraState;
      await state.controller.stopVideoRecording();

      final VideoDataRepository videoDataRepository = VideoDataRepository();

      final videoResult = await getVideoTmpFile();
      await videoDataRepository.createMovie(videoResult, state.files);

      final args = ImagePreviewArguments(
        videoResult,
        true,
        state.screenOrientation,
      );

      store.dispatch(
          NavigateToAction.replace(PreviewPage.routeName, arguments: args));
      store.dispatch(ProcessingAction(false));
    }
    next(action);
  };
}

Middleware<AppState> _createTakePhotoMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is TakePhotoAction) {
      store.dispatch(ProcessingAction(true));
      final CameraState state = store.state.cameraState;
      final path = await getImageTmpFile();
      await state.controller.takePicture(path);

      final args = ImagePreviewArguments(
        path,
        false,
        state.screenOrientation,
      );

      state.key.currentState.showPreview(args, store);
      store.dispatch(ProcessingAction(false));
    }
    next(action);
  };
}

void _initializeNewController(Store store, CameraDescription current) async {
  CameraController controller =
      CameraController(current, ResolutionPreset.high, enableAudio: false);

  await controller.initialize();
  store.dispatch(InitializedCameraControllerAction(controller));
  controller.addListener(() {
    print(controller.value);
    store.dispatch(ControllerStateChangeAction(
        isRecordingVideo: controller.value.isRecordingVideo,
        isTakingPhoto: controller.value.isTakingPicture));
  });
}
