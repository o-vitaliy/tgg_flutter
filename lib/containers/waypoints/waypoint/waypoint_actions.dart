import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointInit {
  final Waypoint waypoint;
  final List<WaypointSubmissionItem> items;

  WaypointInit(this.waypoint, this.items);
}

class WaypointRemoveAction {}

class WaypointStarted {
  final String waypointId;

  WaypointStarted(this.waypointId);
}

class WaypointUpdateAnswer {
  final answer;
  final WaypointSubmission submission;

  WaypointUpdateAnswer(this.answer, this.submission);

  @override
  String toString() {
    return 'WaypointUpdateAnswer{answer: $answer, submission: $submission}';
  }
}

class WaypointSaveAnswer {
  final answer;
  final WaypointSubmission submission;

  WaypointSaveAnswer(this.answer, this.submission);
}

class WaypointSubmit {
  final BuildContext context;

  WaypointSubmit(this.context);
}

class WaypointShowHintAction {}

class WaypointHintShown {
  final String hint;
  final int usedCount;

  WaypointHintShown(this.hint, this.usedCount);
}

@deprecated
class WaypointShowError {
  final String error;
  final WaypointSubmission submission;

  WaypointShowError(this.error, this.submission);
}

class WaypointIncrementAttemptAction{}
