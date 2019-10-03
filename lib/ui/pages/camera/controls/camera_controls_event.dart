import 'package:equatable/equatable.dart';

abstract class CameraControlsEvent extends Equatable {
  CameraControlsEvent([List props = const []]);
}

class CameraControlsHideEvent extends CameraControlsEvent {
  @override
  List<Object> get props => [];
}

class CameraControlsShowEvent extends CameraControlsEvent {
  @override
  List<Object> get props => [];
}
