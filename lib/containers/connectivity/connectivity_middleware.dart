import 'dart:async';
import 'dart:convert';

import 'package:redux/redux.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_action.dart';
import 'package:tgg/containers/connectivity/connectivity_actions.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/data/dao/db.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createConnectivityMiddleware() {
  return [
    new TypedMiddleware<AppState, ConnectivityStartListenAction>(_subscribe()),
    new TypedMiddleware<AppState, ConnectivityStopListenAction>(_unsubscribe()),
  ];
}

StreamSubscription<bool> _subscription;

Middleware<AppState> _subscribe() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is ConnectivityStartListenAction) {
      store.dispatch(ConnectivityChangeSubscriberAction(1));
      if (_subscription == null) {
        connectivityRepo
            .isConnected()
            .then((value) => _doOnConnectivityChanged(store, value));

        _subscription = connectivityRepo.subscribeConnected().listen((value) {
          _doOnConnectivityChanged(store, value);
        });
      }
    }
    next(action);
  };
}

void _doOnConnectivityChanged(Store<AppState> store, bool connected) {
  store.dispatch(ConnectivityStateChangedAction(connected));
  if (connected) _resumeWaypointSync(store);
}

Middleware<AppState> _unsubscribe() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is ConnectivityStopListenAction) {
      store.dispatch(ConnectivityChangeSubscriberAction(-1));
      if (store.state.connectivity.subscribersCount == 0) {
        _subscription?.cancel();
        _subscription = null;
      }
    }
    next(action);
  };
}

void _resumeWaypointSync(Store<AppState> store) async {
  final waypointJsons = await daoWaypoint.getNotSynced();
  final waypoints = waypointJsons
      .map((e) => json.decode(e))
      .map((e) => Waypoint.fromJsonMap(e));
  for (final Waypoint w in waypoints) {
    final waypointId = w.id;

    final answers = await daoAnswer.getAnswerList(waypointId);
    for (final AnswerTableData a in answers) {
      if (SubmissionTypeHelper.isMediaFromString(a.submissionType)) {
        final media = await daoMedia.findByUrl(a.answer);
        if (media == null || media.uploaded == false) {
          if (media.key == null) {
            store.dispatch(AwsAddFileAction(media.fileUrl, w));
          } else {
            store.dispatch(AwsStartFileUpload(media.fileUrl, media.key));
          }
        }
      }
    }

    waypointsRepo.submitAnswer(waypointId);
  }
}
