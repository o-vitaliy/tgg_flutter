import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/validate/submissions_validator.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_submission_item.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createWaypointMiddleware() {
  return [
    new TypedMiddleware<AppState, WaypointsCompletedLoadingAction>(
        _initWaypoint()),
    new TypedMiddleware<AppState, WaypointSubmit>(_submit()),
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
  return (Store store, action, NextDispatcher next) async {
    if (action is WaypointSubmit) {
      final WaypointState waypoint = store.state.waypointState;

      int errors = 0;
      waypoint.items.forEach((item) {
        final type = SubmissionTypeHelper.fromString(item.submission.type);
        String error = validate(type, item.answer);
        if (error != null) errors++;
        store.dispatch(WaypointShowError(error, item.submission));
      });

      if (errors == 0) {}
    }
    next(action);
  };
}
