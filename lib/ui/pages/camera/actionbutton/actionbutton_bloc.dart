import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class ActionButtonBloc extends Bloc<ActionButtonEvent, ActionButtonState> {
  @override
  ActionButtonState get initialState => InitialActionbuttonState();

  @override
  Stream<ActionButtonState> mapEventToState(
    ActionButtonEvent event,
  ) async* {
    if (event is TakePhotoActionButtonEvent) {
      yield TakePhotoActionButtonState();
    }
    if (event is RecordActionButtonEvent) {
      yield RecordActionButtonState(
          isRecording: event.isRecording, isPausable: event.isPausable);
    }
  }
}
