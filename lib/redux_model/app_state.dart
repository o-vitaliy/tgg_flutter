import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tgg/containers/camera/camera_state.dart';
import 'package:tgg/helpers/theme_helper.dart';
import 'package:tgg/models/login_response.dart';
import 'package:tgg/models/playthrough.dart';
import 'package:tgg/redux_model/home_page_state.dart';
import 'package:tgg/redux_model/login_state.dart';
import 'package:tgg/redux_model/upload_files_state.dart';

@immutable
class AppState {
  final ThemeData themeData;
  final bool isLoading;
  final LoginResponse loginResponse;
  final Playthrough playthrough;
  final Timer postLocationTimer;
  final LoginState loginState;
  final HomePageState homePageState;
  final UploadFilesState uploadFilesState;
  final CameraState cameraState;

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
      uploadFilesState: UploadFilesState.initial(),
      cameraState: CameraState(),
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
      homePageState: homePageState ?? this.homePageState
    );
  }
}
