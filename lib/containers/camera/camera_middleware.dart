import 'dart:io';

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/camera/camera_actions.dart';
import 'package:tgg/containers/camera/camera_state.dart';
import 'package:tgg/data/providers/native_provider.dart';
import 'package:tgg/data/video_data_repository.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

List<Middleware<CameraState>> createCameraMiddleware() {
  final initCamera = _createInitCameraMiddleware();
  final restartCamera = _createRestartCameraMiddleware();
  final switchCamera = _createSwitchChangeMiddleware();
  final startRecording = _createStartRecordingMiddleware();
  final stopRecording = _createStopRecordingMiddleware();
  final pauseRecording = _createPauseRecordingMiddleware();
  final takePhoto = _createTakePhotoMiddleware();

  return [
    new TypedMiddleware<CameraState, StartInitCameraAction>(initCamera),
    new TypedMiddleware<CameraState, RestartCameraAction>(restartCamera),
    new TypedMiddleware<CameraState, SwitchCameraAction>(switchCamera),
    new TypedMiddleware<CameraState, TakePhotoAction>(takePhoto),
    new TypedMiddleware<CameraState, StartRecordingAction>(startRecording),
    new TypedMiddleware<CameraState, StopRecordingAction>(stopRecording),
    new TypedMiddleware<CameraState, PauseRecordingAction>(pauseRecording),
    new TypedMiddleware<CameraState, ChangeTorchModeAction>(_switchTorch()),
  ];
}

Middleware<CameraState> _createInitCameraMiddleware() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is StartInitCameraAction) {
      store.dispatch(InitCameraAction(action.args, action.state));
      availableCameras().then((cameras) {
        final current = cameras.first;
        store.dispatch(InitializedCameraAction(cameras, current));
        _initializeNewController(store, current);
      });
    }
    next(action);
  };
}

Middleware<CameraState> _createRestartCameraMiddleware() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is RestartCameraAction) {
      final CameraState cameraState = store.state;

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

Middleware<CameraState> _createSwitchChangeMiddleware() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is SwitchCameraAction) {
      final state = store.state;
      await state.controller?.dispose();
      final current = state.cameras
          .firstWhere((c) => c.lensDirection == action.lensDirection);
      _initializeNewController(store, current);
    }
    next(action);
  };
}

Middleware<CameraState> _createStartRecordingMiddleware() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is StartRecordingAction) {
      final CameraState state = store.state;
      if (state.files.isEmpty) {
        nativeProvider.screenRotationEnable(false);
      }
      final path = await getVideoTmpFile();
      store.dispatch(AddNewFileChangeAction(path));
      await state.controller.startVideoRecording(path);
    }
    next(action);
  };
}

Middleware<CameraState> _createPauseRecordingMiddleware() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is PauseRecordingAction) {
      final CameraState state = store.state;
      await state.controller.safeStopVideoRecording();
    }
    next(action);
  };
}

Middleware<CameraState> _createStopRecordingMiddleware() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is StopRecordingAction) {
      store.dispatch(ProcessingAction(true));
      final CameraState state = store.state;

      if (state.controller.value.isRecordingVideo)
        await state.controller.safeStopVideoRecording();

      nativeProvider.screenRotationEnable(true);

      final VideoDataRepository videoDataRepository = VideoDataRepository();

      final videoResult = await getVideoTmpFile();
      await videoDataRepository.createMovie(videoResult, state.files);

      final args = ImagePreviewArguments(
        videoResult,
        true,
        state.screenOrientation,
      );

      state.key.currentState.showPreview(args, store);
      store.dispatch(ProcessingAction(false));
    }
    next(action);
  };
}

Middleware<CameraState> _createTakePhotoMiddleware() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is TakePhotoAction) {
      store.dispatch(ProcessingAction(true));
      final CameraState state = store.state;
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

Middleware<CameraState> _switchTorch() {
  return (Store<CameraState> store, action, NextDispatcher next) async {
    if (action is ChangeTorchModeAction) {
      await store.state.controller.changeTorchMode(action.toEnable);
    }
    next(action);
  };
}

void _initializeNewController(
    Store<CameraState> store, CameraDescription current) async {
  final CameraState state = store.state;
  final quality = state.captureArgs?.videoParams?.quality;

  final CameraController controller =
      CameraController(current, getPreset(quality), enableAudio: true);

  await controller.initialize();
  store.dispatch(InitializedCameraControllerAction(controller));
  controller.addListener(() {
    store.dispatch(ControllerStateChangeAction(
        isRecordingVideo: controller.value.isRecordingVideo,
        isTakingPhoto: controller.value.isTakingPicture));
  });
}

extension SafeStopController on CameraController {
  Future<void> safeStopVideoRecording() {
    if (value.isRecordingVideo) return stopVideoRecording();
    return Future.value();
  }
}

Future<String> getImageTmpFile() {
  return getTemporaryDirectory()
      .then((extDir) => '${extDir.path}/images')
      .then((dirPath) => Directory(dirPath).create(recursive: true))
      .then((dir) => '${dir.path}/${timestamp()}.jpg');
}

Future<String> getVideoTmpFile() {
  return getTemporaryDirectory()
      .then((extDir) => '${extDir.path}/images')
      .then((dirPath) => Directory(dirPath).create(recursive: true))
      .then((dir) => '${dir.path}/${timestamp()}.mp4');
}

String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

ResolutionPreset getPreset(String quality) {
  switch (quality) {
    case "low":
      return ResolutionPreset.low;
    case "med":
      return ResolutionPreset.medium;
    case "high":
      return ResolutionPreset.high;
    default:
      return ResolutionPreset.medium;
  }
}
