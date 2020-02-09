import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/common/playthrought/playthrought_state.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_state.dart';
import 'package:tgg/containers/camera/camera_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';
import 'package:tgg/containers/waypoints/waypoints_state.dart';
import 'package:tgg/helpers/theme_helper.dart';
import 'package:tgg/models/login_response.dart';
import 'package:tgg/models/playthrough.dart';
import 'package:tgg/common/routing/routing_state.dart';
import 'package:tgg/redux_model/login_state.dart';

@immutable
class AppState {
  final ThemeData themeData;
  final bool isLoading;
  final LoginResponse loginResponse;
  final PlaythroughtState playthrough;
  final Timer postLocationTimer;
  final LoginState loginState;
  final RoutingState homePageState;
  final AwsUploadState uploadFilesState;
  final CameraState cameraState;
  final WaypointsState waypointsState;
  final WaypointState waypointState;
  final Flavor flavor;

  AppState({
    @required this.themeData,
    @required this.isLoading,
    @required this.loginResponse,
    @required this.playthrough,
    @required this.postLocationTimer,
    @required this.loginState,
    @required this.homePageState,
    @required this.uploadFilesState,
    @required this.cameraState,
    @required this.waypointsState,
    @required this.waypointState,
    @required this.flavor,
  });

  factory AppState.initial() {
    return AppState(
      themeData: getDefaultTheme(),
      isLoading: false,
      loginResponse: null,
      playthrough: PlaythroughtState.initial(),
      postLocationTimer: null,
      loginState: null,
      homePageState: null,
      uploadFilesState: AwsUploadState.initial(),
      cameraState: CameraState(),
      waypointsState: WaypointsState.initial(),
      waypointState: null,
      flavor: Flavor.initial(),
    );
  }

  AppState copyWith({ThemeData themeData, bool isLoading}) {
    return new AppState(
      themeData: themeData ?? this.themeData,
      isLoading: isLoading ?? this.isLoading,
      loginResponse: loginResponse ?? this.loginResponse,
      playthrough: playthrough ?? this.playthrough,
      postLocationTimer: postLocationTimer ?? this.postLocationTimer,
      loginState: loginState ?? this.loginState,
      homePageState: homePageState ?? this.homePageState,
      uploadFilesState: uploadFilesState ?? this.uploadFilesState,
      cameraState: cameraState ?? this.cameraState,
      waypointsState: waypointsState ?? this.waypointsState,
      waypointState: waypointState ?? this.waypointState,
      flavor: flavor ?? this.flavor,
    );
  }
}
