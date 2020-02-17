import 'package:meta/meta.dart';

@immutable
class VideoParams {
  final String quality;
  final int length;
  final bool pauseRecord;

  VideoParams({
    @required this.quality,
    @required this.length,
    @required this.pauseRecord,
  });

  static VideoParams defaults() =>
      VideoParams(
          quality: "med", length: 30, pauseRecord: false
      );

}
