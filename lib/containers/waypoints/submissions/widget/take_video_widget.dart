import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/video_params.dart';

import 'media_launcer.dart';

class TakeVideoWidget extends StatelessValueWidget {
  final bool allowGallery;
  final VideoParams videoParams;

  TakeVideoWidget(
      OnValueChange onValueChange, OnSubmit onSubmit, String initialValue, this.allowGallery,  this.videoParams,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(initialValue ?? "image is not selected"),
        RaisedButton(
          child: Text("Take video"),
          onPressed: () => _takeVideo(context),
        ),
      ],
    );
  }

  _takeVideo(BuildContext context) {
    MediaLauncher.startVideo(context, allowGallery, videoParams).then((value) {
      if (value != null) onValueChange(value);
    });
  }
}
