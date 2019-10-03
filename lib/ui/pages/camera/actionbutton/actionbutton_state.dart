import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActionButtonState extends Equatable {
  ActionButtonState([List props = const <dynamic>[]]);
}

class InitialActionbuttonState extends ActionButtonState {
  @override
  List<Object> get props => [];
}

class RecordActionButtonState extends ActionButtonState {
  final bool isRecording;
  final bool isPausable;

  RecordActionButtonState(
      {@required this.isRecording, @required this.isPausable})
      : super([isRecording, isPausable]);
  @override
  List<Object> get props => [isRecording, isPausable];
  @override
  String toString() =>
      'RecordActionButtonState { recording $isRecording pausable $isPausable }';
}

class TakePhotoActionButtonState extends ActionButtonState {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'TakePhotoActionButtonState';
}
