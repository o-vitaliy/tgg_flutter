import 'package:equatable/equatable.dart';

abstract class CameraCountDownTimerEvent extends Equatable {
  CameraCountDownTimerEvent([List props = const []]);
}

class CameraCountDownTimerStarted extends CameraCountDownTimerEvent {
  @override
  List<Object> get props => [];
}

class CameraCountDownTimerStopped extends CameraCountDownTimerEvent {
  @override
  List<Object> get props => [];
}
