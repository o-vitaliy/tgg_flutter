import 'package:flutter/material.dart';
import 'package:tgg/containers/camera/camera_capture_mode.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

class TakePhotoWidget extends ValueWidget {
  TakePhotoWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, String error)
      : super(onValueChange, onSubmit, initialValue, error);

  @override
  State createState() => _TakePhotoInputState();
}

class _TakePhotoInputState extends State<TakePhotoWidget> {
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
          child: Text("Take photo"),
          onPressed: _takePhoto,
        ),
        error != null ? Text(error) : SizedBox.shrink(),
      ],
    );
  }

  _takePhoto() async {
    final result = await Navigator.pushNamed(context, CameraContainer.routeName,
        arguments: CaptureArguments(mode: CameraCaptureMode.PHOTO));

    onValueChange(result);
  }
}
