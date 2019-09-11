import 'package:flutter/material.dart';
import 'package:tgg/ui/widgets/base_square_icon_button.dart';

import 'camera.dart';

typedef CameraActionButtonCallback(CameraState action);

class CameraActionButton extends StatelessWidget {
  final CameraState action;
  final CameraActionButtonCallback callback;

  const CameraActionButton({Key key, this.action, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = _getCameraActionIcon(action);
    return icon != null ? BaseSquareIconButton(
      icon: icon,
      onTap: (c) => callback(action),
    ) : SizedBox.shrink();
  }

  IconData _getCameraActionIcon(CameraState action) {
    if (action is TakePhotoState)
      return Icons.camera_alt;
    else if (action is VideoRecordingState)
      return Icons.play_circle_outline;
    else if (action is VideoRecordingStoppedState)
      return Icons.stop;
    else if (action is VideoRecordingPausedState)
      return Icons.pause_circle_outline;
    return null;
  }
}
