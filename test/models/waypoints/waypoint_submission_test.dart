import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_step.dart';

final mockedWithGallery = """
{"id":"5e3323b6d71f100020fd24e3","title":"Camera","instructions":"Submit a movie or photo, no caption.","position":16,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"camera","title":"Camera","description":"Submit a movie or photo, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"camera"},"content":{"select_gallery_media_enabled":true},"scoring":0}
""";
final mockedWithoutGallery = """
{"id":"5e3323b6d71f100020fd24e3","title":"Camera","instructions":"Submit a movie or photo, no caption.","position":16,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"camera","title":"Camera","description":"Submit a movie or photo, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"camera"},"content":{},"scoring":0}
""";
final mockedOptional = """
{"id":"5e332367d71f100020fd24df","title":"Photo and Text Sequence","instructions":"Between one and five photos with captions, number selectable by player.","position":12,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"photo_and_text_sequence","title":"Photo and Text Sequence","description":"Between one and five photos with captions, number selectable by player.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":["photo",{"type":"text","placeholder":"Caption"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"}]},"content":{},"scoring":0}
""";

final mockedVideo = """
{"id":"5e33237ad71f100020fd24e0","title":"movie","instructions":"Submit a movie, no caption.","position":0,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"movie","title":"Movie","description":"Submit a movie, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"video_max_length","type":"int","default":30,"label":"Max video length","placeholder":"(seconds)","required":false},{"name":"video_quality","type":"select","options":[{"value":"med","label":"Medium (480p)"},{"value":"high","label":"High (720p)"},{"value":"very high","label":"Very High (1080p)"}],"label":"Video quality","default":"med","required":false},{"name":"video_pause_record","type":"bool","default":false,"label":"Pause record","required":false},{"name":"video_disable_rotation","type":"bool","default":false,"label":"Video Disable Rotation","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"movie"},"content":{"video_max_length":"31","video_quality":"high","video_pause_record":true,"select_gallery_media_enabled":true},"scoring":0}
""";

final mockedVideoDefaults = """
{"id":"5e33237ad71f100020fd24e0","title":"movie","instructions":"Submit a movie, no caption.","position":0,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"movie","title":"Movie","description":"Submit a movie, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"video_max_length","type":"int","default":30,"label":"Max video length","placeholder":"(seconds)","required":false},{"name":"video_quality","type":"select","options":[{"value":"med","label":"Medium (480p)"},{"value":"high","label":"High (720p)"},{"value":"very high","label":"Very High (1080p)"}],"label":"Video quality","default":"med","required":false},{"name":"video_pause_record","type":"bool","default":false,"label":"Pause record","required":false},{"name":"video_disable_rotation","type":"bool","default":false,"label":"Video Disable Rotation","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"movie"},"scoring":0}
""";

final mockedNotOptional = mockedWithGallery;

main() {
  group("submission params gallery", () {
    test("enabled", () {
      final map = json.decode(mockedWithGallery);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.galleryEnabled, true);
    });
    test("not enabled", () {
      final map = json.decode(mockedWithoutGallery);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.galleryEnabled, false);
    });
  });

  group("submission params optional", () {
    test("has optionals", () {
      final map = json.decode(mockedOptional);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].optional, false);
      expect(result.behavior.submissionType[1].optional, false);
      expect(result.behavior.submissionType[2].optional, true);
      expect(result.behavior.submissionType[3].optional, true);
    });
    test("no optionals", () {
      final map = json.decode(mockedWithoutGallery);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.optional, false);
    });
  });

  group("video qaulity ", () {
    test("preseted", () {
      final map = json.decode(mockedVideo);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.quality, "high");
    });

    test("default", () {
      final map = json.decode(mockedVideoDefaults);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.quality, "med");
    });
  });
  group("video lenght ", () {
    test("preseted", () {
      final map = json.decode(mockedVideo);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.length, 31);
    });

    test("default", () {
      final map = json.decode(mockedVideoDefaults);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.length, 30);
    });
  });
  group("video pause record ", () {
    test("preseted", () {
      final map = json.decode(mockedVideo);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.pauseRecord, true);
    });

    test("default", () {
      final map = json.decode(mockedVideoDefaults);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.pauseRecord, false);
    });
  });
}
