import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/camera/widgets/camera_timer_container.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';

import 'camera_actions.dart';
import 'camera_controls.dart';
import 'camera_preview_view.dart';

class CameraContainer extends StatelessWidget {
  static const routeName = '/camera';

  @override
  Widget build(BuildContext context) {
    final CaptureArguments args = ModalRoute.of(context).settings.arguments;
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) {
          store.dispatch(StartInitCameraAction(args));
        },
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          if (!vm.initialized) {
            return LoadingIndicator();
          } else {
            return Stack(children: <Widget>[
              CameraPreviewView(),
              !vm.processingResult ? CameraControls() : LoadingIndicator(),
              !vm.needTimer
                  ? SizedBox.shrink()
                  : SafeArea(
                      child: Container(
                      alignment: Alignment.topCenter,
                      child: CameraTimerContainer(),
                    ))
            ]);
          }
        });
  }
}

class _ViewModel {
  final bool processingResult;
  final bool needTimer;
  final bool initialized;

  _ViewModel({this.initialized, this.processingResult, this.needTimer});

  static _ViewModel fromStore(Store<AppState> store) {
    final state = store.state.cameraState;
    return _ViewModel(
      initialized: state.cameras != null,
      processingResult: state.processingResult,
      needTimer: state.needTimer,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          processingResult == other.processingResult &&
          needTimer == other.needTimer &&
          initialized == other.initialized;

  @override
  int get hashCode =>
      processingResult.hashCode ^ needTimer.hashCode ^ initialized.hashCode;
}
