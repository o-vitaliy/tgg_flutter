import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

import 'camera_capture_mode.dart';

@immutable
class CameraState {
  final List<CameraDescription> cameras;
  final GlobalKey<CameraContainerState> key;
  final CameraDescription currentCamera;
  final CameraController controller;
  final CaptureArguments captureArgs;
  final Duration timerDuration;
  final List<String> files;
  final bool processingResult;
  final bool isRecordingVideo;
  final bool isTakingPhoto;
  final int screenOrientation;

  CameraLensDirection get currentCameraLensDirection =>
      controller?.description?.lensDirection;

  bool get hasTorch =>
      controller != null &&
      controller.description.lensDirection == CameraLensDirection.back;

  bool get torchEnabled => hasTorch && controller.value.torchEnabled;

  bool get showTakePhotoButton =>
      !isTakingPhoto && captureArgs?.mode == CameraCaptureMode.PHOTO;

  bool get needTimer => captureArgs?.mode != CameraCaptureMode.PHOTO;

  bool get isHoldToRecord => captureArgs?.videoParams?.pauseRecord == true;

  bool get showStartRecordingButton =>
      captureArgs?.mode == CameraCaptureMode.VIDEO &&
      !isHoldToRecord &&
      !isRecordingVideo;

  bool get showStopRecordingButton {
    if (captureArgs?.mode == CameraCaptureMode.PHOTO) return false;
    if (files.length > 0) return true;
    return false;
  }

  bool get showSwitchCameraButton =>
      controller != null &&
      files.length == 0 &&
      !isRecordingVideo &&
      !isTakingPhoto;

  CameraState({
    this.cameras,
    this.currentCamera,
    this.controller,
    this.screenOrientation = 0,
    this.captureArgs,
    this.timerDuration,
    this.files,
    this.processingResult,
    this.isRecordingVideo,
    this.isTakingPhoto,
    this.key,
  });

  CameraState copyWith({
    List<CameraDescription> cameras,
    CameraDescription currentCamera,
    CameraController controller,
    Duration timerDuration,
    int screenRotation,
    CaptureArguments captureArgs,
    List<String> files,
    bool processingResult,
    bool isRecordingVideo,
    bool isTakingPhoto,
    GlobalKey<CameraContainerState> key,
  }) {
    return CameraState(
      cameras: cameras ?? this.cameras,
      currentCamera: currentCamera ?? this.currentCamera,
      controller: controller ?? this.controller,
      screenOrientation: screenRotation ?? this.screenOrientation,
      captureArgs: captureArgs ?? this.captureArgs,
      timerDuration: timerDuration ?? this.timerDuration,
      files: files ?? this.files,
      processingResult: processingResult ?? this.processingResult,
      isRecordingVideo: isRecordingVideo ?? this.isRecordingVideo,
      isTakingPhoto: isTakingPhoto ?? this.isTakingPhoto,
      key: key ?? this.key,
    );
  }

  factory CameraState.initial() {
    return CameraState();
  }
}
