import 'package:flutter/material.dart';
import 'package:tgg/ui/colors.dart';
import 'package:video_player/video_player.dart';

class VideoProgressWidget extends StatefulWidget {
  final VideoPlayerController controller;
  final VoidCallback onComplete;

  const VideoProgressWidget(
    this.controller, {
    Key key,
    @required this.onComplete,
  }) : super(key: key);

  @override
  State createState() => _VideoProgressState();
}

class _VideoProgressState extends State<VideoProgressWidget> {
  _VideoProgressState() {
    listener = () {
      if (!mounted) {
        return;
      }
      setState(() {});

      final int duration = controller.value.duration.inMilliseconds;
      final int position = controller.value.position.inMilliseconds;
      if (duration - position < 30) {
        onComplete();
      }
    };
  }

  VoidCallback listener;

  VideoPlayerController get controller => widget.controller;

  VoidCallback get onComplete => widget.onComplete;

  @override
  void initState() {
    super.initState();
    controller.addListener(listener);
  }

  @override
  void deactivate() {
    controller.removeListener(listener);
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final int duration = controller.value.duration.inMilliseconds;
    final int position = controller.value.position.inMilliseconds;

    final int durationLeftSeconds = controller.value.duration.inSeconds -
        controller.value.position.inSeconds;

    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        LinearProgressIndicator(
          value: position / duration,
          valueColor: AlwaysStoppedAnimation<Color>(Color(ORANGE)),
          backgroundColor: Colors.transparent,
        ),
        Center(
          child: Text(
            "$durationLeftSeconds sec",
            style: defaultTextStyle,
          ),
        )
      ],
    );
  }
}
