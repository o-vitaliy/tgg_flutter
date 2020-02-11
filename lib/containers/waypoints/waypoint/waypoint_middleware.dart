import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/dialog/dialog_action.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_action.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/submissions_validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
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
      if (action.waypoint != null) {
        final waypoint = action.waypoint;
        final items = waypoint.step.behavior.submissionType
            .map((item) => WaypointSubmissionItem.initial(item))
            .toList();
        store.dispatch(WaypointInit(waypoint, items));
      } else {
        store.dispatch(WaypointRemoveAction());
      }
    }
    next(action);
  };
}

Middleware<AppState> _submit() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointSubmit) {
      final WaypointState waypoint = store.state.waypointState;

      final waypointId = waypoint.waypoint.id;

      List<String> incorrectAnswers = new List<String>();
      waypoint.items.forEach((item) {
        final typeString = item.submission.type;

        daoAnswer.insert(waypointId, typeString, _answerToString(item.answer));

        final type = SubmissionTypeHelper.fromString(typeString);
        String error = validate(type, item.answer, item.submission.choices);
        if (error != null) incorrectAnswers.add(item.answer);
        store.dispatch(WaypointShowError(error, item.submission));
      });

      if (incorrectAnswers.isEmpty) {
        final dialogBuilder = (context) {
          return createSuccessDialog(
            waypoint.attemptsUsed,
            store.state.flavor,
            () {
              Navigator.pop(context);
              store.dispatch(WaypointsStartLoadAction());
            },
          );
        };
        store.dispatch(DialogAction(action.context, dialogBuilder));
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
        store.dispatch(WaypointIncrementAttemptAction());
        store.dispatch(DialogAction(action.context, dialogBuilder));
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
      dynamic answer = action.answer;
      if (SubmissionTypeHelper.isMediaFromString(action.submission.type)) {
        final AppState state = store.state;
        String key = mediaRepo.getKey(
          action.answer,
          state.playthrough.playthrough,
          state.loginResponse.team,
          state.waypointState.waypoint,
        );
        store.dispatch(AddFileToUploadAction(action.answer, key));
        answer = key;
      }

      store.dispatch(WaypointSaveAnswer(answer, action.submission));
    }
    next(action);
  };
}

Middleware<AppState> _showHint() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointShowHintAction) {
      final WaypointState state = store.state.waypointState;
      final hintIndex = state.hintsUsed;
      final hint = state.waypoint.step.behavior.hints[hintIndex];
      store.dispatch(WaypointHintShown(hint, state.hintsUsed + 1));
    }
    next(action);
  };
}

String _answerToString(answer) {
  if (answer is String) {
    return answer;
  } else if (answer is List) {
    return answer.join(answerDelimiter);
  } else {
    throw ArgumentError("unsupported type of answer $answer");
  }
}
