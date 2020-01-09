import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:tgg/containers/camera/camera_middleware.dart';
import 'package:tgg/containers/themed_app.dart';
import 'package:tgg/containers/waypoints/waypoints_middleware.dart';
import 'package:tgg/middleware/auth_middleware.dart';
import 'package:tgg/middleware/login_middleware.dart';
import 'package:tgg/middleware/post_location_middleware.dart';
import 'package:tgg/reducers/app_reducer.dart';
import 'package:tgg/redux_model/app_state.dart';

import 'bloc/auth/authentication.dart';
import 'bloc/theme/theme.dart';
import 'containers/camera/camera_container.dart';
import 'containers/waypoints/waypoint/waypoint_middleware.dart';
import 'data/playthrought_repository.dart';
import 'data/providers/remote_config.dart';
import 'data/simple_bloc_delegate.dart';
import 'ui/auth/login_page.dart';
import 'ui/home.dart';
import 'ui/pages/pages.dart';
import 'ui/splash.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final FirebaseAnalytics _analytics = FirebaseAnalytics();

  final config = Config();

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
        ..add(LoggingMiddleware.printer())
        ..add(NavigationMiddleware<AppState>()));

  @override
  Widget build(BuildContext context) {
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

class App extends StatelessWidget {
  final PlaythroughRepo gameRepo;
  final FirebaseMessaging firebaseMessaging;

  final FirebaseAnalytics analytics;

  App({Key key, this.gameRepo, this.firebaseMessaging, this.analytics})
      : assert(gameRepo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterError.onError = Crashlytics.instance.recordFlutterError;

    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        //_showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );

    return BlocBuilder<ThemeBloc, ThemeChangeState>(builder: (context, state) {
      return MaterialApp(
        title: 'Tgg Demo',
        theme: (state is ThemeChangedState) ? state.theme : ThemeData(),
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: analytics),
        ],
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            // ignore: missing_return
            builder: (context, authState) {
          if (authState is AuthenticationUninitialized)
            return SplashPage();
          else if (authState is AuthenticationAuthenticated)
            return HomePage();
          else if (authState is AuthenticationUnauthenticated)
            return LoginPage();
        }),
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case CameraContainer.routeName:
              return new MyCustomRoute(
                builder: (_) => CameraContainer(),
                settings: settings,
              );
            case PreviewPage.routeName:
              return new MyCustomRoute(
                builder: (_) => PreviewPage(),
                settings: settings,
              );
            case PreviewPage.routeName:
              return new MyCustomRoute(
                builder: (_) => PreviewPage(),
                settings: settings,
              );
          }
          throw AssertionError("unsupported ${settings.name}");
        },
      );
    });
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  print(message);
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return super
        .buildTransitions(context, animation, secondaryAnimation, child);
    //if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    // return child;//new FadeTransition(opacity: animation, child: child);
  }
}
