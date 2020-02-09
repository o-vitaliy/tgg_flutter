import 'package:flutter/material.dart';
import 'package:tgg/containers/camera/camera_capture_mode.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

class TakeVideoWidget extends ValueWidget {
  TakeVideoWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, String error)
      : super(onValueChange, onSubmit, initialValue, error);

  @override
  State createState() => _TakeVideoInputState();
}

class _TakeVideoInputState extends State<TakeVideoWidget> {
  OnValueChange get onValueChange => widget.onValueChange;

  OnSubmit get onSubmit => widget.onSubmit;

  String get error => widget.error;

  String get initialValue => widget.initialValue;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(initialValue ?? "image is not selected"),
        RaisedButton(
          child: Text("Take video"),
          onPressed: _takeVideo,
        ),
        error != null ? Text(error) : SizedBox.shrink(),
      ],
    );
  }

  _takeVideo() {
    Navigator.pushNamed(context, CameraContainer.routeName,
            arguments: CaptureArguments(mode: CameraCaptureMode.SINGE_VIDEO))
        .then((result) {
      onValueChange(result);
    });
  }
}
