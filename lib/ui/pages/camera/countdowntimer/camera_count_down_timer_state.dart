import 'package:equatable/equatable.dart';

abstract class CameraCountDownTimerState extends Equatable {}

class CameraCountDownTimerHiddenState extends CameraCountDownTimerState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'CameraCountDownTimerHiddenState';
}

class CameraCountDownTimerRunningState extends CameraCountDownTimerState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'CameraCountDownTimerRunningState';
}

class CameraCountDownTimerPausedState extends CameraCountDownTimerState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'CameraCountDownTimerPausedState';
}
