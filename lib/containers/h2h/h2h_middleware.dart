import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/dialog/dialog_action.dart';
import 'package:tgg/common/dialog/dialog_helper.dart';
import 'package:tgg/common/routing/route_actions.dart';
import 'package:tgg/containers/h2h/h2h_dialogs.dart';
import 'package:tgg/containers/points/points_actions.dart';
import 'package:tgg/containers/team/team_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

import 'h2h_actions.dart';

List<Middleware<AppState>> createH2HMiddleware() {
  return [
    new TypedMiddleware<AppState, H2HInviteAction>(_invite()),
    new TypedMiddleware<AppState, H2HResendInviteAction>(_resendInvite()),
    new TypedMiddleware<AppState, H2HRefreshAction>(_refresh()),
    new TypedMiddleware<AppState, H2HReceiveInviteAction>(_receiveInvite()),
    new TypedMiddleware<AppState, H2HInviteAcceptedAction>(_acceptedInvite()),
    new TypedMiddleware<AppState, H2HReactInviteAction>(_reactInvite()),
    new TypedMiddleware<AppState, H2HResultAction>(_result()),
  ];
}

Middleware<AppState> _invite() {
  return (final Store<AppState> store, final action,
      final NextDispatcher next) async {
    if (action is H2HInviteAction) {
      final teamId = store.state.team.id;
      final flavor = store.state.flavor;
      final context = DialogHelper.findContext();
      final result = await h2hRepo.invite(teamId, action.pin);
      final status = result.status;
      store.dispatch(DialogAction((c) => createInvitedDialog(
            flavor,
            status.result,
            status.teamName,
            () => Navigator.pop(context),
          )));
      if (result.team != null) {
        store.dispatch(TeamStartUpdateAction(result.team));
      }
    }
    next(action);
  };
}

Middleware<AppState> _resendInvite() {
  return (final Store<AppState> store, final action,
      final NextDispatcher next) async {
    if (action is H2HResendInviteAction) {
      final teamId = action.teamId;
      final team = await teamRepo.updateTeam(teamId);
      store.dispatch(H2HInviteAction(team.pin));
    }
    next(action);
  };
}

Middleware<AppState> _refresh() {
  return (Store store, action, NextDispatcher next) async {
    if (action is H2HRefreshAction) {
      // refresh h2h
      store.dispatch(TeamStartUpdatingAction());
    }
    next(action);
  };
}

Middleware<AppState> _receiveInvite() {
  return (Store store, action, NextDispatcher next) async {
    if (action is H2HReceiveInviteAction) {
      final flavor = store.state.flavor;
      store.dispatch(
        DialogAction((c) => createReceivedInvitedDialog(
              flavor,
              action.teamName,
              () {
                Navigator.pop(DialogHelper.findContext());
                store.dispatch(H2HReactInviteAction(action.teamId, true));
              },
              () {
                Navigator.pop(DialogHelper.findContext());
                store.dispatch(H2HReactInviteAction(action.teamId, false));
              },
            )),
      );
    }
    next(action);
  };
}

Middleware<AppState> _acceptedInvite() {
  return (Store store, action, NextDispatcher next) async {
    if (action is H2HInviteAcceptedAction) {
      store.dispatch(TeamStartUpdatingAction());
      final flavor = store.state.flavor;
      final result = action.accepted ? "was_accepted" : "was_declined";
      store.dispatch(
        DialogAction((c) => createInvitedDialog(
              flavor,
              result,
              action.teamName,
              () => Navigator.pop(DialogHelper.findContext()),
            )),
      );
      _reloadActivePointsAndOpenH2H(store);
    }
    next(action);
  };
}

Middleware<AppState> _reactInvite() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is H2HReactInviteAction) {
      final teamId = store.state.team.id;
      final flavor = store.state.flavor;
      final result = await h2hRepo.acceptInvite(
        teamId,
        action.teamId,
        action.accepted,
      );
      final status = result.status;
      store.dispatch(DialogAction((c) => createInvitedDialog(
            flavor,
            status.result,
            status.teamName,
            () {
              if (status.isOk && action.accepted)
                _reloadActivePointsAndOpenH2H(store);
              Navigator.pop(DialogHelper.findContext());
            },
          )));

      if (result.team != null) {
        store.dispatch(TeamStartUpdateAction(result.team));
      }
    }
    next(action);
  };
}

void _reloadActivePointsAndOpenH2H(Store<AppState> store) {
  store.dispatch(WaypointsStartLoadAction());
  final route = store.state.homePageState.findMode(Mode.head_to_head);
  store.dispatch(RouteChangeCurrentModeAction(route));
}

Middleware<AppState> _result() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is H2HResultAction) {
      final flavor = store.state.flavor;
      final result = action.result;
      String message;
      if (result.agreed) {
        if (result.successful)
          message = "mission:linked:won";
        else
          message = "mission:linked:lost";
      } else {
        message = "mission:linked:disagreed";
      }
      final waypointId = store.state.waypointsPassingState
          .getWaypointForType(Mode.head_to_head)
          .id;
      store.dispatch(DialogAction((c) => createResultDialog(
            flavor,
            message,
            () {
              Navigator.pop(DialogHelper.findContext());
              store.dispatch(TeamStartUpdatingAction());
              store.dispatch(WaypointsStartLoadAction());
              store.dispatch(WaypointRemoveAction(waypointId));
            },
          )));

      store.dispatch(
          PointsAddChallengeAction(waypointId, result.points.toDouble()));
    }
    next(action);
  };
}
