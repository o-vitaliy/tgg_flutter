import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointInit {
  final String waypointId;
  final Waypoint waypoint;
  final List<WaypointSubmissionItem> items;

  WaypointInit(this.waypointId, this.waypoint, this.items);
}

class WaypointRemoveAction {
  final String waypointId;

  WaypointRemoveAction(this.waypointId);
}

class WaypointSwitchToNextAction {
  final Mode mode;

  WaypointSwitchToNextAction(this.mode);
}

class WaypointStarted {
  final String waypointId;

  WaypointStarted(this.waypointId);
}

class WaypointUpdateAnswer {
  final String waypointId;
  final int itemId;
  final answer;
  final WaypointSubmission submission;

  WaypointUpdateAnswer(
      this.waypointId, this.itemId, this.answer, this.submission);

  @override
  String toString() {
    return 'WaypointUpdateAnswer{temId: $itemId answer: $answer, submission: ${submission.type}}';
  }
}

class WaypointSaveAnswer {
  final String waypointId;
  final int itemId;
  final answer;
  final WaypointSubmission submission;

  WaypointSaveAnswer(
      this.waypointId, this.itemId, this.answer, this.submission);

  @override
  String toString() {
    return 'WaypointSaveAnswer{itemId: $itemId answer: $answer, submission: ${submission.type}';
  }
}

class WaypointSubmit {
  final String waypointId;

  WaypointSubmit(
    this.waypointId,
  );
}

class WaypointShowHintAction {
  final String waypointId;

  WaypointShowHintAction(this.waypointId);
}

class WaypointHintShown {
  final String waypointId;
  final String hint;
  final int usedCount;

  WaypointHintShown(this.waypointId, this.hint, this.usedCount);
}

@deprecated
class WaypointShowError {
  final String waypointId;
  final String error;
  final WaypointSubmission submission;

  WaypointShowError(this.waypointId, this.error, this.submission);
}

class WaypointIncrementAttemptAction {
  final String waypointId;

  WaypointIncrementAttemptAction(this.waypointId);
}
