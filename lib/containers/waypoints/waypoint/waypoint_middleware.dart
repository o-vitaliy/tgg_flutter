import 'package:redux/redux.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_action.dart';
import 'package:tgg/containers/points/points_actions.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/waypoint/behavior/behavior.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/helpers/expandable_list.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/redux_model/app_state.dart';

import '../../../constants.dart';
import 'dialogs.dart';

List<Middleware<AppState>> createWaypointMiddleware() {
  return [
    new TypedMiddleware<AppState, WaypointsSelectCurrentAction>(
        _initWaypoint()),
    new TypedMiddleware<AppState, WaypointSubmit>(_submit()),
    new TypedMiddleware<AppState, WaypointSwitchToNextAction>(_goNext()),
    new TypedMiddleware<AppState, WaypointShowHintAction>(_showHint()),
    new TypedMiddleware<AppState, WaypointStarted>(_trackStarted()),
    new TypedMiddleware<AppState, WaypointUpdateAnswer>(_updateAnswer()),
  ];
}

Middleware<AppState> _initWaypoint() {
  return (Store store, action, NextDispatcher next) async {
    if (action is WaypointsSelectCurrentAction) {
      final waypoint = action.waypoint;
      final items = waypoint.step.behavior.submissionType
          .mapIndex(
              (item, index) => WaypointSubmissionItem.initial(index, item))
          .toList();
      store.dispatch(WaypointInit(waypoint.id, waypoint, items));
    }
    next(action);
  };
}

Middleware<AppState> _goNext() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointSwitchToNextAction) {
      final teamId = store.state.team.id;
      final waypoints = await waypointsRepo.getLocalActiveWaypoints(teamId);
      final waypoint = waypoints.firstOrNull((e) => e.mode == action.mode);
      if (waypoint != null) {
        store.dispatch(WaypointsSelectCurrentAction(waypoint));
      } else {
        final toRemove =
            store.state.waypointsPassingState.getWaypointForType(action.mode);
        if (toRemove != null) {
          store.dispatch(WaypointRemoveAction(toRemove.id));
        }
      }
    }
    next(action);
  };
}

Middleware<AppState> _submit() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointSubmit) {
      final String waypointId = action.waypointId;
      store.dispatch(WaypointIncrementAttemptAction(waypointId));
      final WaypointItemState waypoint =
          store.state.waypointsPassingState[waypointId];
      final BaseBehaviorType behaviorType =
          waypoint.waypoint.step.behavior.type;

      final addedAt = DateTime.now();
      if (behaviorType.hasNoSubmissions) {
        await daoAnswer.insert(waypointId, null, null, addedAt);
      } else {
        waypoint.items.forEach((item) async {
          final subType = item.submission.type;
          await daoAnswer.insert(
              waypointId, subType, _answerToString(item.answer), addedAt);
        });
      }
      final validationResult = !behaviorType.hasNoSubmissions
          ? behaviorType.isValid(waypoint.items)
          : null;

      if (!behaviorType.postponedResult) {
        final attemptsUsed = waypoint.attemptsUsed;
        final flavor = store.state.flavor;
        if (validationResult?.isValid ?? true) {
          createSuccessDialog(
            waypoint.waypoint.step.behavior.successMessage,
            attemptsUsed,
            flavor,
          ).then((value) {
            final actions =
                waypoint.waypoint.mode.getAfterSubmitActions(waypoint.waypoint);
            actions.forEach((element) => store.dispatch(element));
          });
          store.dispatch(PointsWaypointSubmittedAction(waypoint));
          waypointsRepo.submitAnswer(waypointId);
        } else {
          createErrorDialog(
              waypoint.waypoint.step.behavior.failureMessage,
              validationResult?.incorrectAnswer,
              waypoint.attemptsUsed,
              store.state.flavor);
        }
      } else {
        store.dispatch(PointsWaypointSubmittedAction(waypoint));
        waypointsRepo.submitAnswer(waypointId);
      }
    }
    next(action);
  };
}

Middleware<AppState> _trackStarted() {
  return (Store store, action, NextDispatcher next) async {
    if (action is WaypointStarted) {
      await waypointsRepo.trackStart(action.waypointId);
    }
    next(action);
  };
}

Middleware<AppState> _updateAnswer() {
  return (Store store, action, NextDispatcher next) async {
    if (action is WaypointUpdateAnswer) {
      final AppState state = store.state;

      final String waypointId = action.waypointId;
      final Waypoint waypoint =
          state.waypointsPassingState[waypointId].waypoint;
      dynamic answer = action.answer;
      if (SubmissionTypeHelper.isMediaFromString(action.submission.type)) {
        store.dispatch(AwsAddFileAction(action.answer, waypoint));
      }
      store.dispatch(WaypointSaveAnswer(
          waypointId, action.itemId, answer, action.submission));

      final type = waypoint.step.behavior.type;
      if (type.autoSubmit) {
        store.dispatch(WaypointSubmit(waypointId));
      }
    }
    next(action);
  };
}

Middleware<AppState> _showHint() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointShowHintAction) {
      final String waypointId = action.waypointId;
      final WaypointItemState state =
          store.state.waypointsPassingState[waypointId];
      final hintIndex = state.hintsUsed;
      final hint = state.waypoint.step.behavior.hints[hintIndex];
      store.dispatch(WaypointHintShown(waypointId, hint, state.hintsUsed + 1));
    }
    next(action);
  };
}

String _answerToString(answer) {
  if (answer == null) {
    return null;
  } else if (answer is bool) {
    return answer.toString();
  } else if (answer is String) {
    return answer;
  } else if (answer is List) {
    return answer.join(answerDelimiter);
  } else {
    throw ArgumentError("unsupported type of answer $answer");
  }
}
