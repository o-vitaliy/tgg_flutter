import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointSubmissionItem {
  final WaypointSubmission submission;
  final answer;

  WaypointSubmissionItem({
    @required this.submission,
    this.answer,
  });

  WaypointSubmissionItem copyWith({
    WaypointSubmission submission,
    answer,
    String hint,
    Optional error,
  }) =>
      WaypointSubmissionItem(
        submission: submission ?? this.submission,
        answer: answer ?? this.answer,
      );

  factory WaypointSubmissionItem.initial(WaypointSubmission submission) {
    return WaypointSubmissionItem(submission: submission);
  }
}
