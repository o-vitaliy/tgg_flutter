import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/media_launcer.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/data/media_repository.dart';
import 'package:tgg/models/waypoints/video_params.dart';

import 'decoration.dart';
import 'take_video_widget.dart';

class CameraWidget extends StatelessValueWidget {
  final bool allowGallery;
  final VideoParams videoParams;

  CameraWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, this.allowGallery, this.videoParams,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: DashRectPainter(),
      color: Color.fromARGB(0, 0, 0, 0),
      child: InkWell(
        onTap: () => _captureMedia(context),
        child: Container(
          height: 160,
          child: Stack(
            children: <Widget>[
              initialValue != null
                  ? Center(
                      child: Image.file(File(initialValue)),
                    )
                  : SizedBox.shrink(),
              Center(
                child: Text(
                  "Tap to take photo or video",
                  style: TextStyle(color: const Color(0xFF999999)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _captureMedia(BuildContext context) async {
    MediaLauncher.startCamera(context, allowGallery, videoParams).then((value) {
      if (value != null) {
        onValueChange(value);
      }
    });
  }

  Widget previewWidget(final String value) {
    if (value == null || value.isEmpty) return SizedBox.shrink();
    final String extension = MediaRepo.getFileExtension(value);
    if (extension == ".jpg") {
      return Center(
        child: Image.file(File(initialValue)),
      );
    } else {
      return VideoPreview(value);
    }
  }
}
