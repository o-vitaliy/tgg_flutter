import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

import 'media_launcer.dart';

class TakeVideoWidget extends StatelessValueWidget {
  TakeVideoWidget(
      OnValueChange onValueChange, OnSubmit onSubmit, String initialValue,
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
    MediaLauncher.startVideo(context, false).then((value) {
      if (value != null) onValueChange(value);
    });
  }
}
