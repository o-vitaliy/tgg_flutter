import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_step.dart';

final mockedWithGallery = """
{"id":"5e3323b6d71f100020fd24e3","title":"Camera","instructions":"Submit a movie or photo, no caption.","position":16,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"camera","title":"Camera","description":"Submit a movie or photo, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"camera"},"content":{"select_gallery_media_enabled":true},"scoring":0}
""";
final mockedWithoutGallery = """
{"id":"5e3323b6d71f100020fd24e3","title":"Camera","instructions":"Submit a movie or photo, no caption.","position":16,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"camera","title":"Camera","description":"Submit a movie or photo, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"camera"},"content":{},"scoring":0}
""";

main() {
  group("submission params", () {
    test("gallery enabled", () {
      final map = json.decode(mockedWithGallery);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.galleryEnabled, true);
    });
    test("gallery not eanbled", () {
      final map = json.decode(mockedWithoutGallery);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.galleryEnabled, false);
    });
  });
}
