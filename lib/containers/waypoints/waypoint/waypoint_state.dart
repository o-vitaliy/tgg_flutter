import 'package:flutter/foundation.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

const double hintPenalty = 0.25;

@immutable
class WaypointState {
  final Waypoint waypoint;
  final List<WaypointSubmissionItem> items;
  final String hint;
  final int hintsUsed;
  final int attemptsUsed;

  int get attemptsRemained => waypoint.step.behavior.numAttempts != null
      ? waypoint.step.behavior.numAttempts - attemptsUsed
      : 1;

  int get _hintsCount => (waypoint.step.behavior.hints?.length ?? 0);

  int get hintRemained => _hintsCount - hintsUsed;

  int get hintPrice {
    if (_hintsCount > 0)
      return (waypoint.points / _hintsCount * hintPenalty).floor();
    else
      return 0;
  }

  WaypointState({
    @required this.waypoint,
    @required this.items,
    @required this.hint,
    @required this.hintsUsed,
    @required this.attemptsUsed,
  });

  WaypointState copyWith({
    Waypoint waypoint,
    List<WaypointSubmissionItem> items,
    String hint,
    int hintsUsed,
    int attemptsUsed,
  }) =>
      WaypointState(
        waypoint: waypoint ?? this.waypoint,
        items: items ?? this.items,
        hint: hint ?? this.hint,
        hintsUsed: hintsUsed ?? this.hintsUsed,
        attemptsUsed: attemptsUsed ?? this.attemptsUsed,
      );
}
