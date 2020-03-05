import 'package:flutter/foundation.dart';
import 'package:tgg/containers/waypoints/submissions/submit_button_helper.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/behavior.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_calculation.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

@immutable
class WaypointItemState {
  final Waypoint waypoint;
  final List<WaypointSubmissionItem> items;
  final String hint;
  final int hintsUsed;
  final int attemptsUsed;

  int get attemptsRemained => waypoint.step.behavior.numAttempts != null
      ? waypoint.step.behavior.numAttempts - attemptsUsed
      : 1;

  int get hintRemained =>
      (waypoint.step.behavior.hints?.length ?? 0) - hintsUsed;

  int get hintPrice => WaypointCalculation.hintPrice(waypoint).toInt();

  bool get isVisible {
    final BaseBehaviorType type = waypoint.step.behavior.type;
    if (type.endless) return false;
    if (type.autoSubmit) return false;
    return true;
  }

  bool get isEnabled => isVisible && SubmitButtonHelper().isEnabledList(items);

  WaypointItemState({
    @required this.waypoint,
    @required this.items,
    this.hint,
    @required this.hintsUsed,
    @required this.attemptsUsed,
  });

  WaypointItemState copyWith({
    Waypoint waypoint,
    List<WaypointSubmissionItem> items,
    String hint,
    int hintsUsed,
    int attemptsUsed,
  }) =>
      WaypointItemState(
        waypoint: waypoint ?? this.waypoint,
        items: items ?? this.items,
        hint: hint ?? this.hint,
        hintsUsed: hintsUsed ?? this.hintsUsed,
        attemptsUsed: attemptsUsed ?? this.attemptsUsed,
      );
}
