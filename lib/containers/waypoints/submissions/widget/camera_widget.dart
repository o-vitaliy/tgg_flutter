import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/media_launcer.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

class CameraWidget extends StatelessValueWidget {
  CameraWidget(
      OnValueChange onValueChange, OnSubmit onSubmit, String initialValue,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(initialValue ?? "image/video is not selected"),
        RaisedButton(
          child: Text("Take image/video"),
          onPressed: () => _captureMedia(context),
        ),
      ],
    );
  }

  void _captureMedia(BuildContext context) async {
    MediaLauncher.startCamera(context, false).then(onValueChange);
  }
}
