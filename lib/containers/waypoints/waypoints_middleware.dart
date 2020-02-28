import 'package:redux/redux.dart';
import 'package:tgg/containers/mission/anytime/anytime_action.dart';
import 'package:tgg/containers/mission/bonus/bonus_action.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/helpers/expandable_list.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createWaypointsMiddleware() {
  final loadWaypoint = _createLoadWaypointMiddleware();

  return [
    new TypedMiddleware<AppState, WaypointsStartLoadAction>(loadWaypoint),
  ];
}

Middleware<AppState> _createLoadWaypointMiddleware() {
  return (Store store, action, NextDispatcher next) async {
    if (action is WaypointsStartLoadAction) {
      store.dispatch(WaypointsStartedLoadingAction());
      waypointsRepo.getActiveWaypoints().then((waypoints) {
        final selectedMain = waypoints.firstOrNull((w) => w.mode == Mode.main);
        if (selectedMain != null) {
          store.dispatch(WaypointsSelectCurrentAction(selectedMain));
        }
        final selectedH2H =
            waypoints.firstOrNull((w) => w.mode == Mode.head_to_head);
        if (selectedH2H != null) {
          store.dispatch(WaypointsSelectCurrentAction(selectedH2H));
        }
        final selectedBonus =
            waypoints.firstOrNull((w) => w.mode == Mode.camera);
        if (selectedBonus != null) {
          store.dispatch(WaypointsSelectCurrentAction(selectedBonus));
        }
        store.dispatch(WaypointsCompletedLoadingAction(waypoints));
        return waypoints;
      }).then((waypoints) {
        store.dispatch(AnytimeStartLoadAction(waypoints));
        store.dispatch(BonusStartLoadAction(waypoints));
      });
    }
    next(action);
  };
}
