import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewWidget extends StatefulWidget {
  final VideoPlayerController videoController;

  const VideoPreviewWidget(this.videoController, {Key key})
      : assert(videoController != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _VideoPreviewState(videoController);
}

class _VideoPreviewState extends State<VideoPreviewWidget> {
  final VideoPlayerController videoController;
  VoidCallback videoPlayerListener;

  _VideoPreviewState(this.videoController);

  @override
  void initState() {
    super.initState();
    if (videoController.value == null && videoController.value.size == null) {
      videoPlayerListener = () {
        if (videoController != null && videoController.value.size != null) {
          // Refreshing the state to update video player with the correct ratio.
          if (mounted) setState(() {});
          videoController.removeListener(videoPlayerListener);
        }
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: AspectRatio(
        child: VideoPlayer(videoController),
        aspectRatio: videoController.value?.size?.aspectRatio ?? 1.0,
      ),
    );
  }
}
