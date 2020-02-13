import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';

import 'media_launcer.dart';

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
    MediaLauncher.startPhoto(context, false).then(onValueChange);
  }
}
