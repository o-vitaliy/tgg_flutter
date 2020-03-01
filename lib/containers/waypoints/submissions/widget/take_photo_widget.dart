import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/models/waypoints/video_params.dart';

import 'decoration.dart';
import 'media_launcer.dart';

class TakePhotoWidget extends StatelessValueWidget {
  final bool allowGallery;
  final VideoParams videoParams;

  TakePhotoWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      String initialValue, this.allowGallery, this.videoParams,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: DashRectPainter(),
      color: Color.fromARGB(0, 0, 0, 0),
      child: InkWell(
        onTap: () => _takePhoto(context),
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
                  "Tap to take photo",
                  style: TextStyle(color: const Color(0xFF999999)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _takePhoto(BuildContext context) async {
    MediaLauncher.startPhoto(context, allowGallery, videoParams).then((value) {
      if (value != null) {
        onValueChange(value);
      }
    });
  }
}
