import 'package:meta/meta.dart';

import 'camera/camera.dart';

class ImagePreviewArguments {
  final String preview;
  final bool isVideo;
  final int screenRotation;

  ImagePreviewArguments(this.preview, this.isVideo, this.screenRotation)
      : assert(preview != null),
        assert(screenRotation != null),
        assert(isVideo != null);
}

class CaptureArguments {
  final CameraCaptureMode mode;

  CaptureArguments({@required this.mode}) : assert(mode != null);
}
