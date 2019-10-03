import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPreview extends StatefulWidget {
  final String videoLink;

  const VideoPreview({Key key, @required this.videoLink})
      : assert(videoLink != null),
        super(key: key);

  @override
  State createState() => _VideoPreviewState(videoLink);
}

class _VideoPreviewState extends State<VideoPreview> {
  final String videoLink;
  VideoPlayerController videoController;
  VoidCallback videoPlayerListener;

  _VideoPreviewState(this.videoLink);

  @override
  Widget build(BuildContext context) {
    if (videoController == null) {
      _startVideoPlayer(videoLink);
      return SizedBox.shrink();
    } else {
      return Center(
        child: AspectRatio(
          child: VideoPlayer(videoController),
          aspectRatio: videoController.value.size.aspectRatio,
        ),
      );
    }
  }

  @override
  void dispose() {
    videoController?.dispose();
    super.dispose();
  }

  Future<void> _startVideoPlayer(String videoPath) async {
    await videoController?.dispose();

    final VideoPlayerController vcontroller =
        VideoPlayerController.file(File(videoPath));
    videoPlayerListener = () {
      if (videoController != null && videoController.value.size != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (mounted) setState(() {});
        videoController.removeListener(videoPlayerListener);
      }
    };
    vcontroller.addListener(videoPlayerListener);
    await vcontroller.setLooping(false);
    await vcontroller.initialize();

    if (mounted) {
      setState(() {
        videoController = vcontroller;
      });
    }
    await vcontroller.play();
  }
}
