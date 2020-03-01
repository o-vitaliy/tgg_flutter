import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/dialog/dialog_action.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_action.dart';
import 'package:tgg/containers/waypoints/submissions/behavior_types.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/submissions_validator.dart';
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

Middleware<AppState> _submit() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointSubmit) {
      final List<String> incorrectAnswers = new List<String>();

      final String waypointId = action.waypointId;
      final WaypointItemState waypoint =
          store.state.waypointsPassingState[waypointId];
      final BehaviorType behaviorType =
          BehaviorTypeHelper.fromString(waypoint.waypoint.step.behavior.id);

      if (BehaviorTypeHelper.noSubmissions(behaviorType)) {
        daoAnswer.insert(waypointId, null, null);
      } else {
        waypoint.items.forEach((item) {
          final subType = item.submission.type;
          daoAnswer.insert(waypointId, subType, _answerToString(item.answer));
          final behaviourType =
              BehaviorTypeHelper.fromString(waypoint.waypoint.step.behavior.id);
          String error =
              validate(behaviourType, item.answer, item.submission.choices);
          if (error != null) incorrectAnswers.add(item.answer);
        });
      }

      if (!BehaviorTypeHelper.postponedResult(behaviorType)) {
        if (incorrectAnswers.isEmpty) {
          final dialogBuilder = (context) {
            return createSuccessDialog(
              waypoint.attemptsUsed,
              store.state.flavor,
              () {
                Navigator.pop(context);
                store.dispatch(WaypointsStartLoadAction());
                store.dispatch(WaypointRemoveAction(waypointId));
              },
            );
          };
          store.dispatch(DialogAction(dialogBuilder));
          await waypointsRepo.submitAnswer(waypointId);
        } else {
          final dialogBuilder = (context) {
            return createErrorDialog(
              incorrectAnswers.join(","),
              waypoint.attemptsUsed,
              store.state.flavor,
              () {
                Navigator.pop(context);
              },
            );
          };
          store.dispatch(WaypointIncrementAttemptAction(waypointId));
          store.dispatch(DialogAction(dialogBuilder));
        }
      } else {
        waypointsRepo.submitAnswer(waypointId).then((_) {});
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
        String key = mediaRepo.getKey(
            action.answer, state.playthrough.playthrough, state.team, waypoint);

        store.dispatch(AddFileToUploadAction(action.answer, key));
      }
      store.dispatch(WaypointSaveAnswer(
          waypointId, action.itemId, answer, action.submission));

      if (BehaviorTypeHelper.autoSubmit(waypoint.step.behavior.id)) {
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
