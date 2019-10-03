import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ActionButtonEvent extends Equatable {
  ActionButtonEvent([List props = const <dynamic>[]]);
}

class RecordActionButtonEvent extends ActionButtonEvent {
  final bool isRecording;
  final bool isPausable;

  RecordActionButtonEvent({@required this.isRecording, this.isPausable})
      : super([isRecording, isPausable]);

  @override
  List<Object> get props => [isRecording, isPausable];

  @override
  String toString() =>
      'RecordActionButtonState { recording $isRecording pausable $isPausable }';
}

class TakePhotoActionButtonEvent extends ActionButtonEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'TakePhotoActionButtonState';
}
