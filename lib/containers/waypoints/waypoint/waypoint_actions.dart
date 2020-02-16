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
  final int itemId;
  final answer;
  final WaypointSubmission submission;

  WaypointUpdateAnswer(this.itemId, this.answer, this.submission);

  @override
  String toString() {
    return 'WaypointUpdateAnswer{temId: $itemId answer: $answer, submission: ${submission.type}}';
  }
}

class WaypointSaveAnswer {
  final int itemId;
  final answer;
  final WaypointSubmission submission;

  WaypointSaveAnswer(this.itemId, this.answer, this.submission);

  @override
  String toString() {
    return 'WaypointSaveAnswer{itemId: $itemId answer: $answer, submission: ${submission.type}';
  }
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

class WaypointIncrementAttemptAction {}
