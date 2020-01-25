import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgg/containers/aws_uploader/aws_upload_state.dart';
import 'package:tgg/containers/camera/camera_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';
import 'package:tgg/containers/waypoints/waypoints_state.dart';
import 'package:tgg/helpers/theme_helper.dart';
import 'package:tgg/models/login_response.dart';
import 'package:tgg/models/playthrough.dart';
import 'package:tgg/redux_model/home_page_state.dart';
import 'package:tgg/redux_model/login_state.dart';

@immutable
class AppState {
  final ThemeData themeData;
  final bool isLoading;
  final LoginResponse loginResponse;
  final Playthrough playthrough;
  final Timer postLocationTimer;
  final LoginState loginState;
  final HomePageState homePageState;
  final AwsUploadState uploadFilesState;
  final CameraState cameraState;
  final WaypointsState waypointsState;
  final WaypointState waypointState;

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
  });

  factory AppState.initial() {
    return AppState(
      themeData: getDefaultTheme(),
      isLoading: false,
      loginResponse: null,
      playthrough: null,
      postLocationTimer: null,
      loginState: null,
      homePageState: null,
      uploadFilesState: AwsUploadState.initial(),
      cameraState: CameraState(),
      waypointsState: WaypointsState.initial(),
      waypointState: null,
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
    );
  }
}
