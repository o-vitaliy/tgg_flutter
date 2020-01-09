import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointSubmissionItem {
  final WaypointSubmission submission;
  final String answer;
  final String error;

  WaypointSubmissionItem({@required this.submission, this.answer, this.error});

  WaypointSubmissionItem copyWith(
          {WaypointSubmission submission, String answer, Optional error}) =>
      WaypointSubmissionItem(
        submission: submission ?? this.submission,
        answer: answer ?? this.answer,
        error: error != null ? error.orNull : this.error,
      );

  factory WaypointSubmissionItem.initial(WaypointSubmission submission) {
    return WaypointSubmissionItem(submission: submission);
  }
}
