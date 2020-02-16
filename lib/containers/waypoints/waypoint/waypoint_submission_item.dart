import 'package:flutter/foundation.dart';
import 'package:tgg/models/waypoints/waypoint_submission.dart';

class WaypointSubmissionItem {
  final int id;
  final WaypointSubmission submission;
  final answer;

  WaypointSubmissionItem({
    @required this.id,
    @required this.submission,
    this.answer,
  });

  WaypointSubmissionItem copyWith({
    WaypointSubmission submission,
    answer,
    String hint,
  }) =>
      WaypointSubmissionItem(
        id: this.id,
        submission: submission ?? this.submission,
        answer: answer ?? this.answer,
      );

  factory WaypointSubmissionItem.initial(
      int id, WaypointSubmission submission) {
    return WaypointSubmissionItem(id: id, submission: submission);
  }
}
