import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/media_launcer.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

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
          onPressed: ()=>_captureMedia(context),
        ),
        error != null ? Text(error) : SizedBox.shrink()
      ],
    );
  }

  void _captureMedia(BuildContext context) async {
    MediaLauncher.startCamera(context, false).then(onValueChange);
  }
}
