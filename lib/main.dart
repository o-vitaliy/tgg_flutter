import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:tgg/common/flavor/flavor_midlleware.dart';

import 'common/dialog/dialog_middleware.dart';
import 'common/messaging/firebase_message.dart';
import 'common/routing/routing_middleware.dart';
import 'containers/aws_uploader/aws_upload_middleware.dart';
import 'containers/camera/camera_container.dart';
import 'containers/camera/camera_middleware.dart';
import 'containers/h2h/h2h_middleware.dart';
import 'containers/mission/anytime/anytime_middleware.dart';
import 'containers/mission/bonus/bonus_middleware.dart';
import 'containers/preview/preview_container.dart';
import 'containers/team/team_middleware.dart';
import 'common/theme/themed_app.dart';
import 'containers/waypoints/waypoint/waypoint_middleware.dart';
import 'containers/waypoints/waypoints_middleware.dart';
import 'data/providers.dart';
import 'middleware/auth_middleware.dart';
import 'containers/login/login_middleware.dart';
import 'middleware/post_location_middleware.dart';
import 'reducers/app_reducer.dart';
import 'redux_model/app_state.dart';
import 'containers/login/login_page.dart';
import 'ui/home.dart';
import 'ui/splash.dart';

void main() {
  runZoned<Future<void>>(() async {
    runApp(ReduxApp());
  }, onError: Crashlytics.instance.recordError);
}

class ReduxApp extends StatelessWidget {
  final store = new Store<AppState>(appReducer,
      initialState: AppState.initial(),
      middleware: []
        ..addAll(createAuthMiddleware())
        ..addAll(createPostingLocationMiddleware())
        ..addAll(createLoginMiddleware())
        ..addAll(createCameraMiddleware())
        ..addAll(createWaypointsMiddleware())
        ..addAll(createWaypointMiddleware())
        ..addAll(createUploadMiddleware())
        ..addAll(createAnytimeMiddleware())
        ..addAll(createBonusMiddleware())
        ..addAll(createH2HMiddleware())
        ..addAll(createTeamMiddleware())
        ..addAll(createRoutingMiddleware())
        ..addAll(createFlavorMiddleware())
        ..add(LoggingMiddleware.printer())
        ..add(NavigationMiddleware<AppState>())
        ..add(DialogMiddleware<AppState>()));

  @override
  Widget build(BuildContext context) {
    FireBaseMessages.create(store, firebaseMessaging);
    return new StoreProvider(
      store: store,
      child: new ThemedApp(
        navigatorKey: NavigatorHolder.navigatorKey,
        onGenerateRoute: _getRoute,
      ),
    );
  }
}

Route _getRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginPage.routeName:
      return _buildRoute(settings, LoginPage());
    case HomePage.routeName:
      return _buildRoute(settings, HomePage());
    case CameraContainer.routeName:
      return _buildRoute(settings, CameraContainer());
    case PreviewPage.routeName:
      return _buildRoute(settings, PreviewPage());
    default:
      return _buildRoute(settings, SplashPage());
  }
}

MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
  return new MaterialPageRoute(
    settings: settings,
    builder: (BuildContext context) => builder,
  );
}
