import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/camera/camera_state.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/widgets/count_down_timer.dart';

import '../camera_actions.dart';

class CameraTimerContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CameraTimerContainerState();
  }
}

class _CameraTimerContainerState extends State<CameraTimerContainer> {
  final countDownTimerKey = GlobalKey<CountDownTimerState>();

  StreamSubscription _subscription;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        onInit: (state) {
          _subscription = StoreProvider.of<AppState>(context, listen: false)
              .onChange
              .map((s) => s.cameraState)
              .map((s) => s.isRecordingVideo)
              .distinct()
              .listen((isRecordingVideo) {
            if (isRecordingVideo)
              countDownTimerKey.currentState.startTimer();
            else
              countDownTimerKey.currentState.stopTimer();
          });
        },
        onDispose: (state) {
          _subscription?.cancel();
          _subscription = null;
        },
        builder: (BuildContext context, _ViewModel vm) {
          return CountDownTimer(
            vm.timerDuration,
            vm.timerDuration,
            key: countDownTimerKey,
            finishedCallback: vm.stopRecording,
          );
        });
  }
}

class _ViewModel {
  final Duration timerDuration;
  final CameraController controller;
  final Function stopRecording;

  _ViewModel({this.timerDuration, this.controller, this.stopRecording});

  static _ViewModel fromStore(Store<AppState> store) {
    final CameraState state = store.state.cameraState;
    return _ViewModel(
      timerDuration: state.timerDuration,
      controller: state.controller,
      stopRecording: () => store.dispatch(StopRecordingAction()),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          timerDuration == other.timerDuration &&
          controller == other.controller;

  @override
  int get hashCode => timerDuration.hashCode ^ controller.hashCode;
}
