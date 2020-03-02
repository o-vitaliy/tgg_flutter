import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:slugify/slugify.dart';
import 'package:tgg/data/dao/dao_media.dart';
import 'package:tgg/data/providers/providers.dart';
import 'package:tgg/models/models.dart';
import 'package:tgg/models/playthrough.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

class MediaRepo {
  final ApiProvider apiProvider;
  final DaoMedia daoMedia;

  MediaRepo({
    this.apiProvider,
    this.daoMedia,
  });

  Future<String> createMedia(
    String mediaFile,
    String key,
    String awsBucketId,
  ) async {
    final values = await _getValues(mediaFile, key, awsBucketId, false, true);
    final result = await apiProvider.createMedia(values: values);
    final resultMap = json.decode(result);
    return resultMap["id"];
  }

  Future<bool> syncFileUpload(
    String mediaId,
    String mediaFile,
    String key,
    String awsBucketId,
  ) async {
    final values = await _getValues(mediaFile, key, awsBucketId, true, false);
    final result = await apiProvider.putMedia(id: mediaId, values: values);
    final resultMap = json.decode(result);
    return resultMap["options"]["is_uploaded"];
  }

  String getFileType(String mime) {
    return mime.split('/').first;
  }

  /// /uploads/ + {media.upload_key}
  /// где upload = {playthrough.started_at:YYYY-MM-DD}/{playthrough_name}/{playthrough.started_at:hh-mm}/{team.name}/{mission.name}-{YYYY-MM-DD-hh-mm-ss}.{extension}
  String getKey(
    String mediaFile,
    Playthrough playthrough,
    Team team,
    Waypoint mission,
  ) {
    File file = File(mediaFile);

    final String datePlaythrough =
        DateFormat("yyyy-MM-dd").format(playthrough.startedAt);
    final String timePlaythrough =
        DateFormat("HH-mm").format(playthrough.startedAt);
    final String dateTime =
        DateFormat("yyyy-MM-dd-HH-mm").format(file.lastModifiedSync());
    final String playthroughName = Slugify(playthrough.name);
    final String teamName = Slugify(team.name);
    final String missionName = Slugify(mission.step.title);
    final String extension = getFileExtension(mediaFile);

    return "uploads/$datePlaythrough/$playthroughName/$timePlaythrough/$teamName/$missionName-$dateTime$extension";
  }

  Future<Map> _getValues(
    String mediaFile,
    String key,
    String awsBucketId,
    bool isUploaded,
    bool isUploading,
  ) async {
    File file = File(mediaFile);
    String mime = lookupMimeType(mediaFile);
    return {
      "media_bucket": awsBucketId,
      "upload_key": key,
      "upload_mime_type": mime,
      "media_mime_type": mime,
      "media_timestamp": file.lastModifiedSync().millisecondsSinceEpoch,
      "media_type": getFileType(mime),
      "media_filename": Uri.file(mediaFile).pathSegments?.last ?? "file_name",
      "media_size": await file.length(),
      "options": {
        "is_uploaded": isUploaded,
        "is_uploading": isUploading,
        "in_gallery": true,
        "is_ready": true,
      }
    };
  }

  static String getFileExtension(String path) {
    return path.substring(path.lastIndexOf("."));
  }
}
