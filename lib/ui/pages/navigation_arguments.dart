import 'package:meta/meta.dart';
import 'package:tgg/containers/camera/camera_capture_mode.dart';
import 'package:tgg/models/waypoints/video_params.dart';

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
  final VideoParams videoParams;

  CaptureArguments({@required this.mode, @required this.videoParams})
      : assert(mode != null),
        assert(videoParams != null);
}
