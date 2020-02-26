import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_step.dart';

final _mockedWithGallery = """
{"id":"5e3323b6d71f100020fd24e3","title":"Camera","instructions":"Submit a movie or photo, no caption.","position":16,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"camera","title":"Camera","description":"Submit a movie or photo, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"camera"},"content":{"select_gallery_media_enabled":true},"scoring":0}
""";
final _mockedWithoutGallery = """
{"id":"5e3323b6d71f100020fd24e3","title":"Camera","instructions":"Submit a movie or photo, no caption.","position":16,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"camera","title":"Camera","description":"Submit a movie or photo, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"camera"},"content":{},"scoring":0}
""";
final _mockedOptional = """
{"id":"5e332367d71f100020fd24df","title":"Photo and Text Sequence","instructions":"Between one and five photos with captions, number selectable by player.","position":12,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"photo_and_text_sequence","title":"Photo and Text Sequence","description":"Between one and five photos with captions, number selectable by player.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":["photo",{"type":"text","placeholder":"Caption"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"},{"type":"photo","optional":true},{"type":"text","optional":true,"placeholder":"Caption (optional)"}]},"content":{},"scoring":0}
""";

final _mockedVideo = """
{"id":"5e33237ad71f100020fd24e0","title":"movie","instructions":"Submit a movie, no caption.","position":0,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"movie","title":"Movie","description":"Submit a movie, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"video_max_length","type":"int","default":30,"label":"Max video length","placeholder":"(seconds)","required":false},{"name":"video_quality","type":"select","options":[{"value":"med","label":"Medium (480p)"},{"value":"high","label":"High (720p)"},{"value":"very high","label":"Very High (1080p)"}],"label":"Video quality","default":"med","required":false},{"name":"video_pause_record","type":"bool","default":false,"label":"Pause record","required":false},{"name":"video_disable_rotation","type":"bool","default":false,"label":"Video Disable Rotation","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"movie"},"content":{"video_max_length":"31","video_quality":"high","video_pause_record":true,"select_gallery_media_enabled":true},"scoring":0}
""";

final _mockedVideoDefaults = """
{"id":"5e33237ad71f100020fd24e0","title":"movie","instructions":"Submit a movie, no caption.","position":0,"mission_id":"5e331e72d71f100020fd24d1","behavior":{"id":"movie","title":"Movie","description":"Submit a movie, no caption.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"video_max_length","type":"int","default":30,"label":"Max video length","placeholder":"(seconds)","required":false},{"name":"video_quality","type":"select","options":[{"value":"med","label":"Medium (480p)"},{"value":"high","label":"High (720p)"},{"value":"very high","label":"Very High (1080p)"}],"label":"Video quality","default":"med","required":false},{"name":"video_pause_record","type":"bool","default":false,"label":"Pause record","required":false},{"name":"video_disable_rotation","type":"bool","default":false,"label":"Video Disable Rotation","required":false},{"name":"select_gallery_media_enabled","type":"bool","default":false,"label":"Allow submission from existing media","required":false},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"movie"},"scoring":0}
""";

final _mockedPlaceholderInContent = """
{"id":"5e42b07dd71f1000102ca16b","title":"A text submission","instructions":"A text submission, anything will be correct.","position":0,"mission_id":"5e42b069d71f1000102ca16a","behavior":{"id":"profile_team_name","title":"Profile: Team Name","description":"Team's submission for this mission is assigned as their team name.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"teamname_placeholder","type":"text","label":"Placeholder for TeamName field","default":"Team name","required":false,"placeholder":"Team Name"},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":{"type":"text","default_placeholder":"Team name","placeholder":"content.teamname_placeholder"}},"content":{"teamname_placeholder":"First name"},"scoring":0}
    """;

final _mockedPlaceholderDefault = """
{"id":"5e42b07dd71f1000102ca16b","title":"A text submission","instructions":"A text submission, anything will be correct.","position":0,"mission_id":"5e42b069d71f1000102ca16a","behavior":{"id":"profile_team_name","title":"Profile: Team Name","description":"Team's submission for this mission is assigned as their team name.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"teamname_placeholder","type":"text","label":"Placeholder for TeamName field","default":"Team name","required":false,"placeholder":"Team Name"},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":{"type":"text","default_placeholder":"Team name"}},"scoring":0}
    """;
final _mockedPlaceholder = """
{"id":"5e4aebd8d71f10001fb8fa40","title":"Phone number","instructions":"*","position":1,"mission_id":"5e42b069d71f1000102ca16a","behavior":{"id":"profile_phone","title":"Profile: Phone Number","description":"Team's submission is logged as their phone number.","fields":[{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":[{"type":"number","placeholder":"Phone number"}]},"content":{},"scoring":0}
    """;

final _mockedNotOptional = _mockedWithGallery;

final _mockedYesChoice = """
{"id":"5e53f0bfd71f10001c5135a2","title":"Questionable Behavior","instructions":"Have you played this before? Do you know the game where two people go back and forth asking questions until someone loses by making a statement? Would you like to play now? Have both teams chosen a representative? Well then why haven't you STARTED already?","position":0,"mission_id":"5e53f0bfd71f10001c5135a1","behavior":{"id":"linked_head_to_head","title":"Head to Head","description":"Competitive linked missions. Pit teams against each other, they collaboratively choose the winner, who gets the most points.","fields":[{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"failure_message","type":"text","label":"Fail message","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":{"type":"yesno","choices":[{"text":"We won!","value":true},{"text":"We lost","value":false}]}},"content":{},"scoring":0}
""";
final _mockedMultiChoice = """
{"id":"5e4af86fd71f10001fb8fa59","title":"Profile multi choice","instructions":"Profile multi choice","position":4,"mission_id":"5e42b069d71f1000102ca16a","behavior":{"id":"profile_multiple_choice","title":"Profile: Multiple Choice","description":"Choose one from a multiple of choices, some of which may be correct. The answer is saved to the team profile.","submission_type":{"type":"choice","choices":"content.choices_with_values"}},"content":{"choices_with_values":[{"text":"choice 1","value":"1"},{"text":"choice 2","value":"2"}],"field_name":"Profile multi choice field"},"scoring":0}
""";

main() {
  group("submission params gallery", () {
    test("enabled", () {
      final map = json.decode(_mockedWithGallery);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.galleryEnabled, true);
    });
    test("not enabled", () {
      final map = json.decode(_mockedWithoutGallery);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.galleryEnabled, false);
    });
  });

  group("submission params optional", () {
    test("has optionals", () {
      final map = json.decode(_mockedOptional);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].optional, false);
      expect(result.behavior.submissionType[1].optional, false);
      expect(result.behavior.submissionType[2].optional, true);
      expect(result.behavior.submissionType[3].optional, true);
    });
    test("no optionals", () {
      final map = json.decode(_mockedNotOptional);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType.first.optional, false);
    });
  });

  group("video qaulity ", () {
    test("preseted", () {
      final map = json.decode(_mockedVideo);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.quality, "high");
    });

    test("default", () {
      final map = json.decode(_mockedVideoDefaults);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.quality, "med");
    });
  });
  group("video lenght ", () {
    test("preseted", () {
      final map = json.decode(_mockedVideo);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.length, 31);
    });

    test("default", () {
      final map = json.decode(_mockedVideoDefaults);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.length, 30);
    });
  });
  group("video pause record ", () {
    test("preseted", () {
      final map = json.decode(_mockedVideo);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.pauseRecord, true);
    });

    test("default", () {
      final map = json.decode(_mockedVideoDefaults);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].videoParams.pauseRecord, false);
    });
  });

  group("placeholder ", () {
    test("in content", () {
      final map = json.decode(_mockedPlaceholderInContent);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].placeholder, "First name");
    });

    test("default", () {
      final map = json.decode(_mockedPlaceholderDefault);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].placeholder, "Team name");
    });

    test("value", () {
      final map = json.decode(_mockedPlaceholder);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.behavior.submissionType[0].placeholder, "Phone number");
    });
  });
  group("choices", () {
    test("yes no", () {
      final map = json.decode(_mockedYesChoice);
      final result = WaypointStep.fromJsonMap(map);
      final submission = result.behavior.submissionType[0];

      expect(submission.choices, isNotNull);
      expect(submission.choices.length, 2);
      expect(submission.choices[0].text, "We won!");
      expect(submission.choices[0].value, true);
      expect(submission.choices[1].text, "We lost");
      expect(submission.choices[1].value, false);
    });

    test("mutli choice", () {
      final map = json.decode(_mockedMultiChoice);
      final result = WaypointStep.fromJsonMap(map);
      final submission = result.behavior.submissionType[0];

      expect(submission.choices, isNotNull);
      expect(submission.choices.length, 2);
      expect(submission.choices[0].text, "choice 1");
      expect(submission.choices[0].value, "1");
      expect(submission.choices[1].text, "choice 2");
      expect(submission.choices[1].value, "2");
    });
  });
}
