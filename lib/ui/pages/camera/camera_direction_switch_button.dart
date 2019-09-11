import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/ui/widgets/base_square_icon_button.dart';

typedef ChangeCameraDirectionCallback(CameraLensDirection cameraLensDirection);

class CameraDirectionSwitchButton extends StatelessWidget {
  final CameraLensDirection direction;
  final ChangeCameraDirectionCallback callback;

  const CameraDirectionSwitchButton({Key key, this.direction, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BaseSquareIconButton(
        icon: _getCameraLensIcon(direction),
        onTap: (context) => callback(_getInvertedLensDirection(direction)),
      );

  /// Returns a suitable camera icon for [direction].
  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
    }
    throw ArgumentError('Unknown lens direction');
  }

  CameraLensDirection _getInvertedLensDirection(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return CameraLensDirection.front;
      case CameraLensDirection.front:
        return CameraLensDirection.back;
      case CameraLensDirection.external:
        return CameraLensDirection.external;
    }
    throw ArgumentError('Unknown lens direction');
  }
}
