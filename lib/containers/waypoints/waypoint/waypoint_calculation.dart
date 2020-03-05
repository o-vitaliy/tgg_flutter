import 'dart:math';

import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

const double _hintPenalty = 0.25;

class WaypointCalculation {
  static double points(WaypointItemState item) {
    final Waypoint waypoint = item.waypoint;
    final stepPoint = waypoint.missionPoints / waypoint.missionStepsCount;
    final successCoefficient =
        waypoint.step.behavior.type.successCoefficient.calculatePoints(item);
    final penalty = hintPenalty(item);
    return max(0, stepPoint * successCoefficient - penalty);
  }

  static double hintPenalty(WaypointItemState item) {
    return item.hintsUsed * hintPrice(item.waypoint);
  }

  static double hintPrice(Waypoint waypoint) {
    final stepPoint = waypoint.missionPoints / waypoint.missionStepsCount;
    final hintPrice = _hintPenalty * stepPoint;
    return hintPrice;
  }
}
