import '../waypoint_item_state.dart';
import 'behaviors.dart';

abstract class SuccessCoefficient {
  double calculatePoints(WaypointItemState state);
}

/// Fixed value 1 for behaviors without any verification
class FixedSuccessCoefficient extends SuccessCoefficient {
  @override
  double calculatePoints(WaypointItemState state) {
    return 1;
  }
}

/// Fixed value 0 for behaviors in challenges
class PostponedSuccessCoefficient extends SuccessCoefficient {
  @override
  double calculatePoints(WaypointItemState state) {
    return 0;
  }
}

/// The coefficient is being calculated based on attempts count
class FixedAnswerSuccessCoefficient extends SuccessCoefficient {
  @override
  double calculatePoints(WaypointItemState state) {
    final result = 1.0 -
        (1.0 / state.waypoint.step.behavior.numAttempts.toDouble()) *
            (state.attemptsUsed - 1.0);

    return ((result * 100.0).truncateToDouble() / 100).clamp(0.0, 1.0);
  }
}

/// The coefficient is being calculated based on distance of answer to the first element
/// in submission variants
class DistanceSuccessCoefficient extends SuccessCoefficient {
  @override
  double calculatePoints(WaypointItemState state) {
    final item = state.items[0];
    final choices = List.from(item.submission.choices);
    final answer = item.answer;

    return _calculate(choices, answer);
  }
}

/// The coefficient is being calculated based on distance of answer to the first element
/// for standard code
class StandardDistanceSuccessCoefficient extends SuccessCoefficient {
  @override
  double calculatePoints(WaypointItemState state) {
    final item = state.items[0];
    final answer = item.answer;

    return _calculate(CodeCustomBehaviorType.codes, answer);
  }
}

/// The coefficient is being calculated based on distance of answer to the
/// first element in answers array
double _calculate(List variants, answer) {
  final result =
      (variants.indexOf(answer).toDouble() + 1.0) / variants.length.toDouble();

  return ((result * 100.0).truncateToDouble() / 100).clamp(0.0, 1.0);
}
