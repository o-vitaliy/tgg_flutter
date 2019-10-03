import 'package:bloc/bloc.dart';

import 'bloc.dart';

class CameraControlsBloc
    extends Bloc<CameraControlsEvent, CameraControlsState> {
  @override
  CameraControlsState get initialState => CameraControlsHiddenState();

  @override
  Stream<CameraControlsState> mapEventToState(
      CameraControlsEvent event) async* {
    if (event is CameraControlsHideEvent) {
      yield CameraControlsHiddenState();
    }
    if (event is CameraControlsShowEvent) {
      yield CameraControlsVisibleState();
    }
  }
}
