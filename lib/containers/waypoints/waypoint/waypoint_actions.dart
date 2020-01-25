import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointInit {
  final Waypoint waypoint;
  final List<WaypointSubmissionItem> items;

  WaypointInit(this.waypoint, this.items);
}


class WaypointStarted{
  final String waypointId;

  WaypointStarted(this.waypointId);
}

class WaypointUpdateAnswer {
  final String answer;
  final WaypointSubmission submission;

  WaypointUpdateAnswer(this.answer, this.submission);
}

class WaypointSaveAnswer {
  final String answer;
  final WaypointSubmission submission;
  final String media;

  WaypointSaveAnswer(this.answer, this.submission, this.media);
}

class WaypointSubmit {}

class WaypointShowError {
  final String error;
  final WaypointSubmission submission;

  WaypointShowError(this.error, this.submission);
}
