import 'package:flutter/material.dart';
import 'package:tgg/containers/camera/camera_capture_mode.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

class CameraWidget extends ValueWidget {
  CameraWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, String error)
      : super(onValueChange, onSubmit, initialValue, error);

  @override
  State createState() => _CameraInputState();
}

class _CameraInputState extends State<CameraWidget> {
  OnValueChange get onValueChange => widget.onValueChange;

  OnSubmit get onSubmit => widget.onSubmit;

  String get error => widget.error;

  String get initialValue => widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(initialValue ?? "image/video is not selected"),
        RaisedButton(
          child: Text("Take image/video"),
          onPressed: _captureMedia,
        ),
        error != null ? Text(error) : SizedBox.shrink(),
        RaisedButton(
          child: const Text("Go!"),
          onPressed: onSubmit,
        )
      ],
    );
  }

  void _captureMedia() async {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text("Select bonus camera"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () =>
                        _startCapture(context, CameraCaptureMode.PHOTO),
                    child: Text("Photo")),
                FlatButton(
                    onPressed: () =>
                        _startCapture(context, CameraCaptureMode.SINGE_VIDEO),
                    child: Text("Video")),
              ],
            ).build(context));
  }

  void _startCapture(BuildContext context, CameraCaptureMode mode) async {
    Navigator.of(context).pop();
    final result = await Navigator.pushNamed(context, CameraContainer.routeName,
        arguments: CaptureArguments(mode: CameraCaptureMode.PHOTO));

    onValueChange(result);
  }
}
