import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/containers/camera/camera_capture_mode.dart';
import 'package:tgg/containers/camera/camera_container.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

class MediaLauncher {
  static Future<String> startCamera(
    BuildContext context,
    bool galleryEnabled,
  ) async {
    final CameraCaptureMode mode = await _selectCaptureMode(context);
    final entry = await _selectMediaSource(context, mode, galleryEnabled);
    return _startMediaPicking(context, entry.key, entry.value);
  }

  static Future<String> startPhoto(
    BuildContext context,
    bool galleryEnabled,
  ) async {
    final entry = await _selectMediaSource(
      context,
      CameraCaptureMode.PHOTO,
      galleryEnabled,
    );
    return _startMediaPicking(context, entry.key, entry.value);
  }

  static Future<String> startVideo(
    BuildContext context,
    bool galleryEnabled,
  ) async {
    final entry = await _selectMediaSource(
      context,
      CameraCaptureMode.SINGE_VIDEO,
      galleryEnabled,
    );
    return _startMediaPicking(context, entry.key, entry.value);
  }

  static Future<CameraCaptureMode> _selectCaptureMode(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: const Text("Camera"),
              content: Text("Take photo or video?"),
              actions: <Widget>[
                FlatButton(
                    onPressed: () =>
                        Navigator.pop(context, CameraCaptureMode.PHOTO),
                    child: Text("Photo")),
                FlatButton(
                    onPressed: () =>
                        Navigator.pop(context, CameraCaptureMode.SINGE_VIDEO),
                    child: Text("Video")),
              ],
            ).build(context));
  }

  static Future<MapEntry<CameraCaptureMode, MediaSource>> _selectMediaSource(
    BuildContext context,
    CameraCaptureMode mode,
    bool galleryEnabled,
  ) {
    if (galleryEnabled == false)
      return Future.value(MapEntry(mode, MediaSource.camera));
    else
      return showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                content: Text("Select Source"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.pop(
                          context, MapEntry(mode, MediaSource.camera)),
                      child: Text("Camera")),
                  FlatButton(
                      onPressed: () => Navigator.pop(
                          context, MapEntry(mode, MediaSource.gallery)),
                      child: Text("Gallery")),
                ],
              ).build(context));
  }

  static Future<String> _startMediaPicking(
    BuildContext context,
    CameraCaptureMode cameraCaptureMode,
    MediaSource mediaSource,
  ) async {
    if (mediaSource == MediaSource.camera) {
      final Future result = Navigator.pushNamed(
          context, CameraContainer.routeName,
          arguments: CaptureArguments(mode: cameraCaptureMode));
      final r = await result;
      return r;
    } else {
      Future<File> pick;
      if (cameraCaptureMode == CameraCaptureMode.PHOTO) {
        pick = ImagePicker.pickImage(source: ImageSource.gallery);
      } else {
        pick = ImagePicker.pickVideo(source: ImageSource.gallery);
      }
      return Observable.fromFuture(pick).map((file) => file.path).first;
    }
  }
}
