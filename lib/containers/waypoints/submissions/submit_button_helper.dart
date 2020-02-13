import 'package:flutter/material.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';

class SubmitButtonHelper {
  @visibleForTesting
  bool isEnabled(WaypointSubmissionItem item) {
    if (item.submission.optional) return true;
    if (item.answer == null) return false;
    if (item.answer is String) return (item.answer as String).isNotEmpty;
    if (item.answer is List) return (item.answer as List).isNotEmpty;
    throw ArgumentError(
        "unsupported type for answer ${item.answer} with type ${item.submission.type}");
  }

  bool isEnabledList(List<WaypointSubmissionItem> items) {
    return items.every((item) => isEnabled(item));
  }
}
