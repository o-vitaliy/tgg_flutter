import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/models/waypoints/waypoint_step.dart';

final mockedChoices =
    """{"id":"5e25ff4bd71f10001e0e455b","title":"select correct","instructions":"Select correct answer","position":0,"mission_id":"5e25ff15d71f10001e0e455a","behavior":{"id":"multiple_choice","title":"Multiple Choice","description":"Choose one from a multiple of choices, only some of which are correct.","fields":[{"name":"choices","type":"list:text+check","label":"Options","required":true},{"name":"hints","type":"list:text","label":"Hints","required":false},{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"failure_message","type":"text","label":"Fail message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"num_attempts","type":"int","default":3,"label":"Number of attempts","required":false,"placeholder":"Number of attempts allowed"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":{"type":"choice","choices":"content.choices"}},"content":{"choices":[{"text":"first","value":false},{"text":"second","value":false},{"text":"correct","value":true},{"text":"last","value":false}]},"scoring":0}""";
final mockedVerifiedText =
    """{"id":"5e30700cd71f10001e54c25c","title":"Type A letter","instructions":"Type A or a letter","position":0,"mission_id":"5e306f89d71f10001e54c25b","behavior":{"id":"text_answer","title":"Text Answer","description":"A text submission checked for correctness by the game.","fields":[{"name":"correct","type":"text","label":"Correct answer","required":true,"placeholder":"Correct answer. Use commas to separate multiple options."},{"name":"hints","type":"list:text","label":"Hints","required":false},{"name":"success_message","type":"text","label":"Success message","required":false},{"name":"failure_message","type":"text","label":"Fail message","required":false},{"name":"timelimit","type":"int","label":"Time limit","default":null,"required":false,"placeholder":"Time limit (in minutes)"},{"name":"num_attempts","type":"int","default":3,"label":"Number of attempts","required":false,"placeholder":"Number of attempts allowed"},{"name":"presentation_text","type":"text:long","label":"Presentation text","required":false,"placeholder":"Presentation Text"},{"name":"presentation_image","type":"upload","label":"Presentation image","required":false,"placeholder":"Image key","object_key":"media_key","s3":{"bucket":"gogame-breadcrumb-display-media","folder":"GameShow"}},{"name":"presentation_title","type":"text","label":"Presentation title","required":false,"placeholder":"Presentation Title (overrides mission step title)"},{"name":"display_answer","type":"text","label":"GGP Display answer","required":false,"placeholder":"Correct display answer. Will display on screen view"},{"name":"question_type","type":"text","label":"GGP Question type","required":false,"placeholder":"Question type"},{"name":"timer","type":"int","label":"GGP Timer","required":false},{"name":"stop_auto_play","type":"bool","default":false,"label":"GGP Stop autoplay","required":false},{"name":"is_one_time_mission","type":"bool","default":false,"label":"Is Mission available only once per playthrough","required":false}],"submission_type":"text"},"content":{"correct":"A, a"},"scoring":0}""";

main() {
  group("parse waypoint step with ", () {
    test("Choices", () {
      final map = json.decode(mockedChoices);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.id, "5e25ff4bd71f10001e0e455b");
      expect(result.behavior.id, "multiple_choice");
      expect(result.behavior.submissionType.first.type, "choice");

      final choices = result.behavior.submissionType.first.choices;
      expect(choices.length, 4);
    });
    test("Verified text", () {
      final map = json.decode(mockedVerifiedText);
      final result = WaypointStep.fromJsonMap(map);
      expect(result.id, "5e30700cd71f10001e54c25c");
      expect(result.behavior.submissionType.first.type, "text");

      final choices = result.behavior.submissionType.first.choices;
      expect(choices.length, 2);
    });
  });
}
