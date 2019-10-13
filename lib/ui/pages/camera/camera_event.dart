import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'camera.dart';

abstract class CameraEvent extends Equatable {
  CameraEvent([List props = const []]);
}

class InitialCameraCaptureEvent extends CameraEvent {
  final CameraCaptureMode mode;

  InitialCameraCaptureEvent({
    @required this.mode,
  }) : super([mode]);
  @override
  List<Object> get props => [mode];
  @override
  String toString() => 'InitialCameraCaptureEvent { mode: $mode }';
}

class CaptureClickEvent extends CameraEvent {
  final CameraController cameraController;

  CaptureClickEvent({@required this.cameraController})
      : super([cameraController]);

  @override
  String toString() =>
      'CaptureClickEvent { cameraController: $cameraController }';

  @override
  List<Object> get props => [cameraController];
}

class StartVideoRecording extends CameraEvent {
  final CameraController cameraController;

  StartVideoRecording({@required this.cameraController})
      : super([cameraController]);

  @override
  List<Object> get props => [cameraController];

  @override
  String toString() =>
      'StartVideoRecording { cameraController: $cameraController }';
}

class PauseVideoRecording extends CameraEvent {
  final CameraController cameraController;

  PauseVideoRecording({@required this.cameraController})
      : super([cameraController]);
  @override
  List<Object> get props => [cameraController];
  @override
  String toString() =>
      'PauseVideoRecording { cameraController: $cameraController }';
}

class StopVideoRecording extends CameraEvent {
  final CameraController cameraController;

  StopVideoRecording({@required this.cameraController})
      : super([cameraController]);
  @override
  List<Object> get props => [cameraController];
  @override
  String toString() =>
      'StopVideoRecording { cameraController: $cameraController }';
}
