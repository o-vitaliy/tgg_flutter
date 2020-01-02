import 'package:flutter/material.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/ui/pages/pages.dart';

typedef ButtonBuilder = Widget Function(
    BuildContext context, VoidCallback onPressed);

class BonusCameraBuilder extends StatelessWidget {
  final ButtonBuilder buttonBuilder;

  const BonusCameraBuilder({Key key, this.buttonBuilder}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      buttonBuilder(context, () => onPressed(context));

  void onPressed(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              content: Text("Select bonus camera"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () =>
                        startBonusCamera(context, CameraCaptureMode.PHOTO),
                    child: Text("Photo")),
                FlatButton(
                    onPressed: () => startBonusCamera(
                        context, CameraCaptureMode.SINGE_VIDEO),
                    child: Text("Video")),
                FlatButton(
                    onPressed: () => startBonusCamera(
                        context, CameraCaptureMode.MULTI_VIDEO),
                    child: Text("PausableVideo")),
              ],
            ).build(context));
  }

  void startBonusCamera(BuildContext context, CameraCaptureMode mode) {
    Navigator.of(context).pop();
    Navigator.pushNamed(context, CameraContainer.routeName,
        arguments: CaptureArguments(mode: mode));
  }
}
