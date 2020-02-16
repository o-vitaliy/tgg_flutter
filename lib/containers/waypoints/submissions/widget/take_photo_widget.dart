import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

import 'media_launcer.dart';

class TakePhotoWidget extends StatelessValueWidget {
  TakePhotoWidget(
      OnValueChange onValueChange, OnSubmit onSubmit, String initialValue,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(initialValue ?? "image is not selected"),
        RaisedButton(
          child: Text("Take photo"),
          onPressed: () => _takePhoto(context),
        ),
      ],
    );
  }

  _takePhoto(BuildContext context) async {
    MediaLauncher.startPhoto(context, false).then((value) {
      if (value != null) {
        onValueChange(value);
      }
    });
  }
}
