import 'package:camera/camera.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class CameraTorchButtonEvent extends Equatable {
  CameraTorchButtonEvent([List props = const []]);
}

class CameraTorchButtonHideEvent extends CameraTorchButtonEvent {
  @override
  List<Object> get props => [];
}

class CameraTorchButtonEnableEvent extends CameraTorchButtonEvent {
  final CameraController controller;

  CameraTorchButtonEnableEvent({@required this.controller})
      : super([controller]);

  @override
  List<Object> get props => [controller];
}

class CameraTorchButtonDisableEvent extends CameraTorchButtonEvent {
  final CameraController controller;

  CameraTorchButtonDisableEvent({@required this.controller})
      : super([controller]);

  @override
  List<Object> get props => [controller];
}
