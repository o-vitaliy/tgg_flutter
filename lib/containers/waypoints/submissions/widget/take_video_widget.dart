import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

import 'media_launcer.dart';

class TakeVideoWidget extends ValueWidget {
  TakeVideoWidget(
      OnValueChange onValueChange, OnSubmit onSubmit, String initialValue)
      : super(onValueChange, onSubmit, initialValue);

  @override
  State createState() => _TakeVideoInputState();
}

class _TakeVideoInputState extends State<TakeVideoWidget> {
  OnValueChange get onValueChange => widget.onValueChange;

  OnSubmit get onSubmit => widget.onSubmit;

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
      ],
    );
  }

  _takeVideo() {
    MediaLauncher.startVideo(context, false).then((value) {
      if (value != null) onValueChange(value);
    });
  }
}
