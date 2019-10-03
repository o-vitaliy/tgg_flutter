import 'dart:core';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';

class NativeProvider {
  const NativeProvider();

  Future<String> createMovie(String output, List<String> paths) async {
    String moviePath;
    try {
      moviePath = await _getChannel().then((channel) => channel.invokeMethod(
          'createMovie', {"output": output, "videoPaths": paths}));
      debugPrint("Movie created path: $moviePath");
    } on PlatformException {}

    return moviePath;
  }

  Future<Uint8List> getVideoThumbnail(String videoPath) async {
    Uint8List imageBytes;
    try {
      imageBytes = await _getChannel().then((channel) =>
          channel.invokeMethod('getVideoThumbnail', {"videoPath": videoPath}));
      debugPrint("Movie created path: $videoPath");
    } on PlatformException {}

    return imageBytes;
  }

  Future screenRotationEnable(bool enabled) async {
    final channel = await _getChannel();
    await channel.invokeMethod('screenRotation', {"enabled": enabled});
  }

  Future<MethodChannel> _getChannel() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return MethodChannel('${packageInfo.packageName}/channel');
  }
}

const nativeProvider = NativeProvider();
