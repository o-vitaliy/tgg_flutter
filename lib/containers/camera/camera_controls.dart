import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/camera/camera_actions.dart';
import 'package:tgg/containers/camera/widgets/camera_torch_button.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/keys.dart';
import 'package:tgg/ui/pages/camera/actionbutton/actionbutton.dart';
import 'package:tgg/ui/pages/camera/camera_direction_switch_button.dart';
import 'package:tgg/ui/widgets/base_square_icon_button.dart';

class CameraControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                children: <Widget>[
                  buildTopRow(vm),
                  Spacer(),
                  buildBottomRow(vm)
                ],
              ),
            ),
          );
        });
  }

  Widget buildTopRow(_ViewModel vm) {
    if (vm.hasTorch) {
      return Container(
          alignment: Alignment.topLeft,
          child: CameraTorchButton(
              key: Keys.cameraTorchButton,
              enabled: vm.torchEnabled,
              callback: vm.switchTorch));
    } else {
      return SizedBox.shrink();
    }
  }

  Widget buildBottomRow(_ViewModel vm) {
    final items = List<Widget>();

    if (vm.showTakePhotoButton) {
      items.add(Container(
        alignment: Alignment.center,
        child: TakePhotoButton(onTakePhotoClick: vm.takePhoto),
      ));
    }

    if (vm.showStartRecordingButton) {
      items.add(Container(
          alignment: Alignment.center,
          child: BaseSquareIconButton(
            icon: FontAwesomeIcons.solidPlayCircle,
            onTap: (c) => vm.startRecording(),
          )));
    }
    if (vm.showPauseRecordingButton) {
      items.add(Container(
          alignment: Alignment.center,
          child: BaseSquareIconButton(
            icon: FontAwesomeIcons.solidPauseCircle,
            onTap: (c) => vm.pauseRecording(),
          )));
    }
    if (vm.showStopRecordingButton) {
      items.add(Container(
          alignment: Alignment.centerRight,
          child: BaseSquareIconButton(
            icon: FontAwesomeIcons.solidStopCircle,
            onTap: (c) => vm.stopRecording(),
          )));
    }
    if (vm.showSwitchCameraButton) {
      items.add(Container(
          alignment: Alignment.centerRight,
          child: BaseSquareIconButton(
            icon: getCameraLensIcon(vm.currentCameraLensDirection),
            onTap: (c) => vm.switchCamera(
                getInvertedLensDirection(vm.currentCameraLensDirection)),
          )));
    }

    return SizedBox(
      width: double.infinity,
      height: 58,
      child: Stack(
        fit: StackFit.expand,
        children: items,
      ),
    );
  }
}

class _ViewModel {
  final bool hasTorch;
  final bool torchEnabled;
  final bool showTakePhotoButton;
  final bool showStartRecordingButton;
  final bool showPauseRecordingButton;
  final bool showStopRecordingButton;
  final bool showSwitchCameraButton;
  final CameraLensDirection currentCameraLensDirection;

  final Function(bool) switchTorch;
  final Function startRecording;
  final Function pauseRecording;
  final Function stopRecording;
  final Function takePhoto;
  final Function(CameraLensDirection) switchCamera;

  _ViewModel({
    this.showTakePhotoButton,
    this.showStartRecordingButton,
    this.showPauseRecordingButton,
    this.showStopRecordingButton,
    this.showSwitchCameraButton,
    this.hasTorch,
    this.torchEnabled,
    this.switchTorch,
    this.stopRecording,
    this.startRecording,
    this.pauseRecording,
    this.takePhoto,
    this.switchCamera,
    this.currentCameraLensDirection,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final state = store.state.cameraState;
    return _ViewModel(
      hasTorch: state.hasTorch,
      torchEnabled: state.torchEnabled,
      showTakePhotoButton: state.showTakePhotoButton,
      showStartRecordingButton: state.showStartRecordingButton,
      showPauseRecordingButton: state.showPauseRecordingButton,
      showStopRecordingButton: state.showStopRecordingButton,
      showSwitchCameraButton: state.showSwitchCameraButton,
      currentCameraLensDirection: state.currentCameraLensDirection,
      switchTorch: (toEnable) =>
          store.dispatch(ChangeTorchModeAction(toEnable)),
      startRecording: () => store.dispatch(StartRecordingAction()),
      pauseRecording: () => store.dispatch(PauseRecordingAction()),
      stopRecording: () => store.dispatch(StopRecordingAction()),
      takePhoto: () => store.dispatch(TakePhotoAction()),
      switchCamera: (lensDirection) =>
          store.dispatch(SwitchCameraAction(lensDirection)),
    );
  }
}
