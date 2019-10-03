import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class CameraTorchButtonState extends Equatable {
  CameraTorchButtonState([List props = const <dynamic>[]]);
}

class InitialCameraTorchButtonState extends CameraTorchButtonState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'HiddenCameraTorchButtonState';
}

class HiddenCameraTorchButtonState extends CameraTorchButtonState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'HiddenCameraTorchButtonState';
}

class ModeChangedCameraTorchButtonState extends CameraTorchButtonState {
  final bool enabled;

  ModeChangedCameraTorchButtonState({@required this.enabled})
      : super([enabled]);
  @override
  List<Object> get props => [enabled];
  @override
  String toString() =>
      'ModeChangedCameraTorchButtonState {enabled : $enabled }';
}
