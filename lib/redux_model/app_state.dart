import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/common/playthrought/playthrought_state.dart';
import 'package:tgg/common/routing/routing_state.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_state.dart';
import 'package:tgg/containers/connectivity/connectivity_state.dart';
import 'package:tgg/containers/h2h/h2h_state.dart';
import 'package:tgg/containers/login/login_state.dart';
import 'package:tgg/containers/mission/anytime/anytime_state.dart';
import 'package:tgg/containers/mission/bonus/bonus_state.dart';
import 'package:tgg/containers/points/points_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';
import 'package:tgg/containers/waypoints/waypoints_state.dart';
import 'package:tgg/models/blueprint_model.dart';
import 'package:tgg/models/models.dart';

@immutable
class AppState {
  final bool isLoading;
  final Team team;
  final PlaythroughtState playthrough;
  final Timer postLocationTimer;
  final LoginState loginState;
  final RoutingState homePageState;
  final AwsUploadState uploadFilesState;
  final WaypointsState waypointsState;
  final WaypointState waypointsPassingState;
  final Flavor flavor;
  final BlueprintModel blueprint;
  final AnytimeState anytime;
  final BonusState bonus;
  final H2HState h2h;
  final PointsState points;
  final ConnectivityState connectivity;

  AppState({
    @required this.isLoading,
    @required this.team,
    @required this.playthrough,
    @required this.postLocationTimer,
    @required this.loginState,
    @required this.homePageState,
    @required this.uploadFilesState,
    @required this.waypointsState,
    @required this.waypointsPassingState,
    @required this.flavor,
    @required this.blueprint,
    @required this.anytime,
    @required this.bonus,
    @required this.h2h,
    @required this.points,
    @required this.connectivity,
  });

  factory AppState.initial() {
    return AppState(
      isLoading: false,
      team: null,
      playthrough: PlaythroughtState.initial(),
      postLocationTimer: null,
      loginState: null,
      homePageState: RoutingState.initial([]),
      uploadFilesState: AwsUploadState.initial(),
      waypointsState: WaypointsState.initial(),
      waypointsPassingState: WaypointState.initial(),
      flavor: Flavor.initial(),
      blueprint: null,
      anytime: AnytimeState.initial(),
      bonus: BonusState.initial(),
      h2h: H2HState.initial(),
      points: PointsState.initial(),
      connectivity: ConnectivityState.initial(),
    );
  }

  AppState copyWith({ThemeData themeData, bool isLoading}) {
    return new AppState(
      isLoading: isLoading ?? this.isLoading,
      team: team ?? this.team,
      playthrough: playthrough ?? this.playthrough,
      postLocationTimer: postLocationTimer ?? this.postLocationTimer,
      loginState: loginState ?? this.loginState,
      homePageState: homePageState ?? this.homePageState,
      uploadFilesState: uploadFilesState ?? this.uploadFilesState,
      waypointsState: waypointsState ?? this.waypointsState,
      waypointsPassingState:
          waypointsPassingState ?? this.waypointsPassingState,
      flavor: flavor ?? this.flavor,
      blueprint: blueprint ?? this.blueprint,
      anytime: anytime ?? this.anytime,
      bonus: bonus ?? this.bonus,
      h2h: h2h ?? this.h2h,
      points: points ?? this.points,
      connectivity: connectivity ?? this.connectivity,
    );
  }
}
