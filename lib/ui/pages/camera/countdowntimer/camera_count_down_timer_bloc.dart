import 'package:bloc/bloc.dart';

import 'bloc.dart';

class CameraCountDownTimerBloc
    extends Bloc<CameraCountDownTimerEvent, CameraCountDownTimerState> {
  @override
  CameraCountDownTimerState get initialState =>
      CameraCountDownTimerHiddenState();

  @override
  Stream<CameraCountDownTimerState> mapEventToState(
      CameraCountDownTimerEvent event) async* {
    if (event is CameraCountDownTimerStarted) {
      yield CameraCountDownTimerRunningState();
    }
    if (event is CameraCountDownTimerStopped) {
      yield CameraCountDownTimerPausedState();
    }
  }
}
