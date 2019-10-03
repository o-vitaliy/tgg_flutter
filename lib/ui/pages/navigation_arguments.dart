import 'package:meta/meta.dart';

import 'camera/camera.dart';

class ImagePreviewArguments {
  final String preview;
  final bool isVideo;

  ImagePreviewArguments(this.preview, this.isVideo)
      : assert(preview != null),
        assert(isVideo != null);
}

class CaptureArguments {
  final CameraCaptureMode mode;

  CaptureArguments({@required this.mode}) : assert(mode != null);
}
