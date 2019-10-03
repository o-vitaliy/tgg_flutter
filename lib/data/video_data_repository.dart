import 'dart:typed_data';

import 'package:tgg/data/providers/native_provider.dart';

class VideoDataRepository {
  const VideoDataRepository();

  Future<String> createMovie(String output, List<String> paths) async {
    return nativeProvider.createMovie(output, paths);
  }

  Future<Uint8List> getVideoThumbnail(String videoPath) async {
    return nativeProvider.getVideoThumbnail(videoPath);
  }
}
