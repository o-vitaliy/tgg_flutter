import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:redux/redux.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/keys.dart';

import 'camera_actions.dart';

class CameraPreviewView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          if (!vm.initialized) {
            return SizedBox.shrink();
          } else {
            return Stack(
              children: <Widget>[
                buildPreviewWidget(vm.controller, vm.onChangeOrientation),
              ],
            );
          }
        });
  }

  Widget buildPreviewWidget(CameraController controller,
      Function(int) onChangeOrientation,) {
    return NativeDeviceOrientationReader(
      useSensor: false,
      builder: (context) {
        final orientation = NativeDeviceOrientationReader.orientation(context);

        final screenRotation =
        orientation == NativeDeviceOrientation.landscapeRight ? 180 : 0;

        onChangeOrientation(screenRotation);

        final isLand = orientation == NativeDeviceOrientation.landscapeLeft ||
            orientation == NativeDeviceOrientation.landscapeRight;
        int quarterTurns;
        switch (orientation) {
          case NativeDeviceOrientation.landscapeLeft:
            quarterTurns = -1;
            break;
          case NativeDeviceOrientation.landscapeRight:
            quarterTurns = 1;
            break;
          default:
            quarterTurns = 0;
        }
        return Center(
          key: Keys.cameraPreviewScreen,
          child: AspectRatio(
            aspectRatio: isLand
                ? 1 / controller.value.aspectRatio
                : controller.value.aspectRatio,
            child: RotatedBox(
              quarterTurns: quarterTurns,
              child: CameraPreview(controller),
            ),
          ),
        );
      },
    );
  }
}

class _ViewModel {
  final CameraController controller;
  final Function(int) onChangeOrientation;

  _ViewModel({this.controller, this.onChangeOrientation,});

  bool get initialized => controller != null;

  static _ViewModel fromStore(Store<AppState> store) {
    final state = store.state.cameraState;
    final screenOrientation = state.screenOrientation;
    return _ViewModel(
        controller: state.controller,
        onChangeOrientation: (orientation) {
          if (orientation != screenOrientation)  store.dispatch(SaveScreenRotation(orientation));
        },
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              controller == other.controller;

  @override
  int get hashCode => controller.hashCode;
}
