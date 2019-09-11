import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/ui/widgets/count_down_timer.dart';

import '../navigation_arguments.dart';
import '../preivew_image.dart';
import 'camera.dart';

const defaultDuration = Duration(seconds: 30);

class CameraPage extends StatefulWidget {
  final CameraCaptureMode mode;

  const CameraPage({Key key, this.mode = CameraCaptureMode.PHOTO})
      : super(key: key);

  @override
  State createState() => CameraPageState(mode);
}

class CameraPageState extends State<CameraPage> {
  Stream<List<CameraDescription>> stream;
  final CameraCaptureMode mode;

  CameraPageState(this.mode);

  @override
  void initState() {
    super.initState();
    stream = Stream.fromFuture(availableCameras());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, AsyncSnapshot<List<CameraDescription>> snapshot) =>
          snapshot.hasData
              ? BlocProvider<CameraBloc>(
                  builder: (context) {
                    return CameraBloc()
                      ..dispatch(InitialCameraCaptureEvent(mode: mode));
                  },
                  child: _CameraScreen(cameras: snapshot.data))
              : SizedBox.shrink(),
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
  Widget build(BuildContext context) {
    final cameraBloc = BlocProvider.of<CameraBloc>(context);
    return BlocListener<CameraBloc, CameraState>(
        listener: (context, state) {
          if (state is PhotoWasTakenState) {
            Navigator.pushNamed(context, PreviewImage.routeName,
                arguments: ImagePreviewArguments(state.imagePath));
          }
        },
        child: Stack(
          children: <Widget>[
            _cameraPreviewWidget(),
            SafeArea(child: _controlsWidget(cameraBloc))
          ],
        ));
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Initializing',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: CameraPreview(controller),
      );
    }
  }

  Widget _controlsWidget(CameraBloc cameraBloc) {
    return Container(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            _getCountDownTimer(cameraBloc),
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
                      child: CameraDirectionSwitchButton(
                          direction: currentCamera.lensDirection,
                          callback: (result) => onNewCameraSelected(cameras
                              .where((it) => it.lensDirection == result)
                              .first)),
                    )
                  ],
                ))
          ],
        ));
  }

  Widget _getCountDownTimer(CameraBloc cameraBloc) {
    return BlocListener<CameraBloc, CameraState>(
        bloc: cameraBloc,
        listener: (context, state) {
          if (state is VideoRecordingState) {
            (countDownTimerKey.currentState as CountDownTimerState)
                .startTimer();
          } else if (state is VideoRecordingStoppedState ||
              state is VideoRecordingPausedState) {
            (countDownTimerKey.currentState as CountDownTimerState).stopTimer();
          }
        },
        child: CameraBlocWidget(cameraBloc,
            (BuildContext context, CameraState state) {
          if (state is TakeVideoState)
            return CountDownTimer(defaultDuration, key: countDownTimerKey);
          else
            return SizedBox.shrink();
        }));
  }

  Widget _getCameraActionButton(CameraBloc cameraBloc) {
    return CameraBlocWidget(cameraBloc,
        (BuildContext context, CameraState state) {
      if (state != null) {
        return CameraActionButton(
            action: state,
            callback: (action) => cameraBloc
                .dispatch(CaptureClickEvent(cameraController: controller)));
      } else {
        return SizedBox.shrink();
      }
    });
  }

  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(cameraDescription, ResolutionPreset.high);
    currentCamera = cameraDescription;
    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
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
}

class CameraBlocWidget extends StatelessWidget {
  final CameraBloc cameraBloc;
  final BlocWidgetBuilder<CameraState> builder;

  const CameraBlocWidget(this.cameraBloc, this.builder, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CameraBloc, CameraState>(
        bloc: cameraBloc, builder: builder);
  }
}

void logError(String code, String message) =>
    print('Error: $code\nError Message: $message');

void logErrorMessage(String message) => print('Error: $message');
