import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/data/providers/native_provider.dart';
import 'package:tgg/models/waypoints/video_params.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';

import 'decoration.dart';
import 'media_launcer.dart';

class TakeVideoWidget extends StatelessValueWidget {
  final bool allowGallery;
  final VideoParams videoParams;

  TakeVideoWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, this.allowGallery, this.videoParams,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: DashRectPainter(),
      color: Color.fromARGB(0, 0, 0, 0),
      child: InkWell(
        onTap: () => _takeVideo(context),
        child: Container(
          height: 160,
          child: Stack(
            children: <Widget>[
              initialValue != null
                  ? Center(
                      child: VideoPreview(initialValue),
                    )
                  : SizedBox.shrink(),
              Center(
                child: Text(
                  initialValue == null
                      ? "Tap to take video"
                      : "Video is taken.\nTap to retake",
                  style: TextStyle(color: const Color(0xFF999999)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _takeVideo(BuildContext context) {
    MediaLauncher.startVideo(context, allowGallery, videoParams).then((value) {
      if (value != null) onValueChange(value);
    });
  }
}

class VideoPreview extends StatelessWidget {
  final String path;

  const VideoPreview(this.path, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: nativeProvider.getVideoThumbnail(path).asStream(),
        builder: (context, data) {
          if (data == null || data.data == null) {
            return LoadingIndicator();
          } else {
            return Image.memory(data.data);
          }
        });
  }
}
