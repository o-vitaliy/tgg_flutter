import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'camera.dart';

abstract class CameraEvent extends Equatable {
  CameraEvent([List props = const []]) : super(props);
}

class InitialCameraCaptureEvent extends CameraEvent {
  final CameraCaptureMode mode;

  InitialCameraCaptureEvent({
    @required this.mode,
  }) : super([mode]);

  @override
  String toString() => 'InitialCameraCaptureEvent { mode: $mode }';
}

class CaptureClickEvent extends CameraEvent {
  final CameraController cameraController;

  CaptureClickEvent({
  @required this.cameraController});

  @override
  String toString() =>
      'CaptureClickEvent { cameraController: $cameraController }';
}
