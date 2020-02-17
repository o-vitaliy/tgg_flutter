import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/media_launcer.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/video_params.dart';

class CameraWidget extends StatelessValueWidget {
  final bool allowGallery;
  final VideoParams videoParams;

  CameraWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, this.allowGallery, this.videoParams,
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
    MediaLauncher.startCamera(context, allowGallery, videoParams)
        .then(onValueChange);
  }
}
