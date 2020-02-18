import 'package:flutter/cupertino.dart';
import 'package:tgg/helpers/map_utils.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';
import 'package:tgg/models/waypoints/video_params.dart';
import 'package:tgg/models/waypoints/waypoint_parser_utils.dart';

class WaypointSubmission {
  final String type;
  final String placeholder;
  final choices;
  final bool galleryEnabled;
  final bool optional;
  final VideoParams videoParams;

  WaypointSubmission._({
    @required this.type,
    this.placeholder,
    @required this.choices,
    @required this.galleryEnabled,
    @required this.optional,
    @required this.videoParams,
  });

  static List<WaypointSubmission> from(dynamic map, {step}) {
    List<WaypointSubmission> result = List();
    if (map is Map) {
      result.add(WaypointSubmission._fromMap(map, step: step));
    } else if (map is String) {
      result.add(WaypointSubmission._fromString(map, step: step));
    } else if (map is List) {
      result.addAll(map.expand((m) => WaypointSubmission.from(m, step: step)));
    }
    return result;
  }

  static WaypointSubmission _fromMap(Map<String, dynamic> map, {step}) {
    return WaypointSubmission._(
      type: map["type"],
      placeholder: _getPlaceholder(map, step),
      choices: SubmissionChoice.from(getAt(step, map["choices"])) ??
          _getTextVariants(step),
      galleryEnabled: _getGalleryEnabled(step),
      optional: map["optional"] ?? false,
      videoParams: VideoParams(
        length: _getVideoMaxLength(step),
        pauseRecord: _getVideoPuaseRecord(step),
        quality: _getVideoQuality(step),
      ),
    );
  }

  static WaypointSubmission _fromString(String type, {step}) {
    return WaypointSubmission._(
      type: type,
      choices: _getTextVariants(step),
      galleryEnabled: _getGalleryEnabled(step),
      optional: false,
      videoParams: VideoParams(
        length: _getVideoMaxLength(step),
        pauseRecord: _getVideoPuaseRecord(step),
        quality: _getVideoQuality(step),
      ),
    );
  }

  static bool _getGalleryEnabled(step) {
    return step != null
        ? getBoolValue(step, "select_gallery_media_enabled")
        : false;
  }

  static int _getVideoMaxLength(step) {
    return step != null ? getIntValue(step, "video_max_length") : 30;
  }

  static bool _getVideoPuaseRecord(step) {
    return step != null ? getBoolValue(step, "video_pause_record") : false;
  }

  static String _getVideoQuality(step) {
    return step != null ? getStringValue(step, "video_quality") : "med";
  }

  static List<String> _getTextVariants(step) {
    final variants =
        getAt(step, "content.correct")?.split(",")?.map((v) => v.trim());
    return variants != null ? List<String>.from(variants) : null;
  }

  static String _getPlaceholder(map, step) {
    final String placeholder = map["placeholder"];
    if (placeholder != null) {
      return getAt(step, placeholder) ?? placeholder;
    } else {
      return map["default_placeholder"];
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WaypointSubmission &&
          runtimeType == other.runtimeType &&
          type == other.type &&
          placeholder == other.placeholder;

  @override
  int get hashCode => type.hashCode ^ type.hashCode ^ placeholder.hashCode;
}
