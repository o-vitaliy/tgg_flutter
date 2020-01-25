import 'package:redux/redux.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_action.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/submissions_validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createWaypointMiddleware() {
  return [
    new TypedMiddleware<AppState, WaypointsCompletedLoadingAction>(
        _initWaypoint()),
    new TypedMiddleware<AppState, WaypointSubmit>(_submit()),
    new TypedMiddleware<AppState, WaypointStarted>(_trackStarted()),
    new TypedMiddleware<AppState, WaypointUpdateAnswer>(_updateAnswer()),
  ];
}

Middleware<AppState> _initWaypoint() {
  return (Store store, action, NextDispatcher next) async {
    if (action is WaypointsCompletedLoadingAction) {
      final waypoints = action.waypoints.first;
      final items = waypoints.step.behavior.submissionType
          .map((item) => WaypointSubmissionItem.initial(item))
          .toList();
      store.dispatch(WaypointInit(waypoints, items));
    }
    next(action);
  };
}

Middleware<AppState> _submit() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is WaypointSubmit) {
      final WaypointState waypoint = store.state.waypointState;

      int errors = 0;
      waypoint.items.forEach((item) {
        final type = SubmissionTypeHelper.fromString(item.submission.type);
        String error = validate(type, item.answer);
        if (error != null) errors++;
        store.dispatch(WaypointShowError(error, item.submission));
      });

      if (errors == 0) {
        await waypointsRepo.submitAnswer(
            waypoint.waypoint.id,
            waypoint.items.map((i) => {
                  i.submission.type: i.answer,
                }),
            waypoint.items.map((i) => i.media).where((i) => i != null));

        store.dispatch(WaypointsStartLoadAction());
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
      String answer = action.answer;
      String media;
      if (SubmissionTypeHelper.isMediaFromString(action.submission.type)) {
        final AppState state = store.state;
        String key = mediaRepo.getKey(
          action.answer,
          state.playthrough,
          state.loginResponse.team,
          state.waypointState.waypoint,
        );
        store.dispatch(AddFileToUploadAction(action.answer, key));
        answer = key;
        media = key;
      }

      store.dispatch(WaypointSaveAnswer(answer, action.submission, media));
    }
    next(action);
  };
}
