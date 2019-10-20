import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tgg/ui/widgets/base_square_icon_button.dart';

import '../navigation_arguments.dart';
import '../pages.dart';

const defaultDuration = Duration(seconds: 30);

class CameraPage extends StatelessWidget {
  static const routeName = '/cameraPage';

  @override
  Widget build(BuildContext context) {
    final CaptureArguments args = ModalRoute.of(context).settings.arguments;
    final mode = args.mode;

    final ActionButtonBloc actionButtonBloc = ActionButtonBloc();
    final CameraControlsBloc cameraControlsBloc = CameraControlsBloc();
    final CameraTorchButtonBloc cameraTorchButtonBloc = CameraTorchButtonBloc();
    final CameraCountDownTimerBloc cameraCountDownTimerBloc =
        CameraCountDownTimerBloc();
    final CameraBloc cameraBloc = CameraBloc(cameraControlsBloc,
        cameraCountDownTimerBloc, actionButtonBloc, cameraTorchButtonBloc)
      ..dispatch(InitialCameraCaptureEvent(mode: mode));

    return Scaffold(
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: Stream.fromFuture(availableCameras()),
        builder: (context, AsyncSnapshot<List<CameraDescription>> snapshot) =>
            snapshot.hasData
                ? MultiBlocProvider(providers: [
                    BlocProvider<CameraControlsBloc>(
                        builder: (context) => cameraControlsBloc),
                    BlocProvider<CameraCountDownTimerBloc>(
                        builder: (context) => cameraCountDownTimerBloc),
                    BlocProvider<CameraBloc>(builder: (context) => cameraBloc),
                    BlocProvider<ActionButtonBloc>(
                        builder: (context) => actionButtonBloc),
                    BlocProvider<CameraTorchButtonBloc>(
                      builder: (context) => cameraTorchButtonBloc,
                    )
                  ], child: _CameraScreen(cameras: snapshot.data))
                : SizedBox.shrink(),
      ),
    );
  }
}

class _CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const _CameraScreen({Key key, this.cameras}) : super(key: key);

  @override
  State createState() => _CameraScreenState(cameras);
}

class _CameraScreenState extends State<_CameraScreen>
    with WidgetsBindingObserver {
  final List<CameraDescription> cameras;
  CameraController controller;
  CameraDescription currentCamera;

  final GlobalKey countDownTimerKey = GlobalKey();

  _CameraScreenState(this.cameras);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    onNewCameraSelected(cameras.first);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      controller?.dispose();
    } else if (state == AppLifecycleState.resumed) {
      if (controller != null) {
        onNewCameraSelected(controller.description);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cameraBloc = BlocProvider.of<CameraBloc>(context);
    return BlocListener<CameraBloc, CameraState>(
        bloc: cameraBloc,
        listener: (context, state) {
          if (state is PhotoWasTakenState) {
            Navigator.popAndPushNamed(context, PreviewPage.routeName,
                arguments: ImagePreviewArguments(state.imagePath, false));
          }
          if (state is VideoWasTakenState) {
            Navigator.popAndPushNamed(context, PreviewPage.routeName,
                arguments: ImagePreviewArguments(state.videoPath, true));
          }
        },
        child: Stack(
          children: <Widget>[
            _cameraPreviewWidget(),
            SafeArea(child: _controlsWidget(context, cameraBloc))
          ],
        ));
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Center(
          child: Text(
        'Initializing',
        style: TextStyle(
          color: Colors.white,
          fontSize: 22.0,
          fontWeight: FontWeight.w900,
        ),
      ));
    } else {
      return Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: CameraPreview(controller),
        ),
      );
    }
  }

  Widget _controlsWidget(BuildContext context, CameraBloc cameraBloc) {
    return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                _getCameraTorchButton(context),
                Container(
                  alignment: Alignment.center,
                  child: _getCountDownTimer(),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
                width: double.infinity,
                height: 58,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: _getCameraActionButton(cameraBloc),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: _getCameraSwitchButton(),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: _getStopRecordingButton(),
                    )
                  ],
                ))
          ],
        ));
  }

  Widget _getCountDownTimer() => CameraTimerWidget(duration: defaultDuration);

  Widget _getCameraActionButton(CameraBloc cameraBloc) {
    return ActionButton(
      onTakePhotoClick: () =>
          cameraBloc.dispatch(CaptureClickEvent(cameraController: controller)),
      onRecordClick: () => cameraBloc
          .dispatch(StartVideoRecording(cameraController: controller)),
      onPauseClick: () => cameraBloc
          .dispatch(PauseVideoRecording(cameraController: controller)),
      onStopClick: () =>
          cameraBloc.dispatch(StopVideoRecording(cameraController: controller)),
    );
  }

  Widget _getCameraSwitchButton() {
    return CameraControlsBlocWidget(
        builder: (context) => CameraDirectionSwitchButton(
              direction: currentCamera.lensDirection,
              callback: (result) => onNewCameraSelected(
                  cameras.where((it) => it.lensDirection == result).first),
            ));
  }

  Widget _getCameraTorchButton(BuildContext context) {
    final cameraBloc = BlocProvider.of<CameraTorchButtonBloc>(context);

    return BlocBuilder<CameraTorchButtonBloc, CameraTorchButtonState>(
        bloc: cameraBloc,
        builder: (context, state) {
          if (state is InitialCameraTorchButtonState ||
              state is ModeChangedCameraTorchButtonState) {
            final enabled = controller?.value?.torchEnabled ?? false;
            return CameraTorchButton(
              enabled: enabled,
              callback: (_) => cameraBloc.dispatch(enabled
                  ? CameraTorchButtonDisableEvent(controller: controller)
                  : CameraTorchButtonEnableEvent(controller: controller)),
            );
          } else {
            return SizedBox.shrink();
          }
        });
  }

  Widget _getStopRecordingButton() {
    return CameraBlocWidget(
      builder: (context, state) {
        if (state is VideoRecordingPausedState) {
          return BaseSquareIconButton(
            icon: FontAwesomeIcons.check,
            onTap: (context) => BlocProvider.of<CameraBloc>(context)
                .dispatch(StopVideoRecording(cameraController: controller)),
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high,
        enableAudio: false);
    currentCamera = cameraDescription;
    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (controller.value.hasError) {
        logErrorMessage('Camera error ${controller.value.errorDescription}');
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      logError(e.code, e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void deactivate() {
    controller?.dispose();
    controller = null;
    super.deactivate();
  }
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

void logErrorMessage(String message) => print('Error: $message');
