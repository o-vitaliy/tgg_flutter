import 'package:equatable/equatable.dart';

abstract class CameraControlsState extends Equatable {}

class CameraControlsHiddenState extends CameraControlsState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'CameraControlsHiddenState';
}

class CameraControlsVisibleState extends CameraControlsState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'CameraControlsHiddenState';
}
