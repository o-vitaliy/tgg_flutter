import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tgg/data/providers/providers.dart';
import 'package:tgg/data/video_data_repository.dart';

import 'camera.dart';

class CameraBloc extends Bloc<CameraEvent, CameraState> {
  final CameraControlsBloc cameraControlsBloc;
  final CameraCountDownTimerBloc cameraCountDownTimerBloc;
  final ActionButtonBloc actionButtonBloc;
  final CameraTorchButtonBloc cameraTorchButtonBloc;

  static const VideoDataRepository _videoDataRepository = VideoDataRepository();

  CameraBloc(this.cameraControlsBloc, this.cameraCountDownTimerBloc,
      this.actionButtonBloc, this.cameraTorchButtonBloc);

  @override
  CameraState get initialState => InitialState();

  CameraCaptureMode mode;
  int maxVideosCount;

  final _videoList = List<String>();

  @override
  Stream<CameraState> mapEventToState(CameraEvent event) async* {
    if (event is InitialCameraCaptureEvent) {
      mode = event.mode;
      maxVideosCount = mode == CameraCaptureMode.MULTI_VIDEO ? 10000 : 1;
      cameraControlsBloc.dispatch(CameraControlsShowEvent());

      if (mode == CameraCaptureMode.PHOTO) {
        actionButtonBloc.dispatch(TakePhotoActionButtonEvent());
      } else {
        dispatchRecordingStateChanged(false);
      }
    }
    if (event is CaptureClickEvent) {
      cameraControlsBloc.dispatch(CameraControlsHideEvent());

      final cameraController = event.cameraController;
      final imagePath = await getImageTmpFile();
      await cameraController.takePicture(imagePath);

      cameraTorchButtonBloc.dispatch(
          CameraTorchButtonDisableEvent(controller: cameraController));
      cameraTorchButtonBloc.dispatch(CameraTorchButtonHideEvent());
      cameraController.changeTorchMode(false);
      yield PhotoWasTakenState(imagePath);
      nativeProvider.screenRotationEnable(true).then((_) {});
    }
    if (event is StartVideoRecording &&
        !event.cameraController.value.isRecordingVideo) {
      cameraControlsBloc.dispatch(CameraControlsHideEvent());
      startVideoRecording(event.cameraController);
      dispatchRecordingStateChanged(true);
      nativeProvider.screenRotationEnable(false).then((_) {});
      yield VideoRecordingState();
    }
    if (event is PauseVideoRecording &&
        event.cameraController.value.isRecordingVideo) {
      stopVideoRecording(event.cameraController);
      dispatchRecordingStateChanged(false);

      yield VideoRecordingPausedState();
    }
    if (event is StopVideoRecording) {
      if (event.cameraController.value.isRecordingVideo)
        stopVideoRecording(event.cameraController);
      dispatchRecordingStateChanged(false);
      yield VideoRecordingPausedState();
      cameraTorchButtonBloc.dispatch(
          CameraTorchButtonDisableEvent(controller: event.cameraController));
      cameraTorchButtonBloc.dispatch(CameraTorchButtonHideEvent());

      event.cameraController.changeTorchMode(false);
      yield* mergeVideos();
      nativeProvider.screenRotationEnable(true).then((_) {});
    }
  }

  void startVideoRecording(CameraController cameraController) async {
    final videoPath = await getVideoTmpFile();
    _videoList.add(videoPath);
    await cameraController.startVideoRecording(videoPath);
  }

  void pauseVideoRecording(CameraController cameraController) async {
    await cameraController.stopVideoRecording();
  }

  void stopVideoRecording(CameraController cameraController) async {
    await cameraController.stopVideoRecording();
  }

  void dispatchRecordingStateChanged(bool recording) {
    cameraCountDownTimerBloc.dispatch(recording
        ? CameraCountDownTimerStarted()
        : CameraCountDownTimerStopped());

    actionButtonBloc.dispatch(RecordActionButtonEvent(
        isRecording: recording,
        isPausable: mode == CameraCaptureMode.MULTI_VIDEO));
  }

  //https://github.com/bipinvaylu/MovieMaker-Flutter
  Stream<CameraState> mergeVideos() async* {
    final videoResult = await getVideoTmpFile();
    await _videoDataRepository.createMovie(videoResult, _videoList);

    yield VideoWasTakenState(videoResult);
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
