import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class CameraTorchButtonBloc
    extends Bloc<CameraTorchButtonEvent, CameraTorchButtonState> {
  @override
  CameraTorchButtonState get initialState => InitialCameraTorchButtonState();

  @override
  Stream<CameraTorchButtonState> mapEventToState(
    CameraTorchButtonEvent event,
  ) async* {
    if (event is CameraTorchButtonHideEvent) {
      yield HiddenCameraTorchButtonState();
    } else if (event is CameraTorchButtonEnableEvent) {
      await event.controller.changeTorchMode(true);
      yield ModeChangedCameraTorchButtonState(enabled: true);
    } else if (event is CameraTorchButtonDisableEvent) {
      await event.controller.changeTorchMode(false);
      yield ModeChangedCameraTorchButtonState(enabled: false);
    }
  }
}
