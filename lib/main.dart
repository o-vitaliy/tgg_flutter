import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/auth/authentication.dart';
import 'bloc/auth/login.dart';
import 'bloc/game/game.dart';
import 'bloc/theme/theme.dart';
import 'data/game_repository.dart';
import 'data/location_repo.dart';
import 'data/login_repo.dart';
import 'data/simple_bloc_delegate.dart';
import 'ui/auth/login_page.dart';
import 'ui/home.dart';
import 'ui/pages/pages.dart';
import 'ui/pages/post_location/bloc.dart';
import 'ui/splash.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final loginRepo = LoginRepo();
  final gameRepo = GameRepo(loginRepo);
  final locationRepo = LocationRepo(loginRepo);

  final themeBloc = ThemeBloc(gameRepository: gameRepo);
  final gameBloc = GameBloc();
  final authBloc = AuthenticationBloc(
    gameRepo: gameRepo,
    themeBloc: themeBloc,
    gameBloc: gameBloc,
  );
  final loginBloc = LoginBloc(
    loginRepo: loginRepo,
    gameRepo: gameRepo,
    authenticationBloc: authBloc,
    gameBloc: gameBloc,
  );

  runZoned<Future<void>>(() async {
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(builder: (context) {
            return authBloc..dispatch(AppStarted());
          }),
          BlocProvider<ThemeBloc>(builder: (context) => themeBloc),
          BlocProvider<LoginBloc>(builder: (context) => loginBloc),
          BlocProvider<GameBloc>(builder: (context) => gameBloc),
          BlocProvider<PostLocationBloc>(
              builder: (context) => PostLocationBloc(locationRepo)),
        ],
        child: App(gameRepo: gameRepo),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
}

class App extends StatelessWidget {
  final GameRepo gameRepo;
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();
  final FirebaseAnalytics analytics = FirebaseAnalytics();

  App({Key key, this.gameRepo})
      : assert(gameRepo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterError.onError = Crashlytics.instance.recordFlutterError;

    _firebaseMessaging.getToken().then((value)=> print("firebase token " + value));

    _firebaseMessaging.configure(
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
        // _navigateToItemDetail(message);
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
            return LoginPage(gameRepository: gameRepo);
        }),
        routes: {
          CameraPage.routeName: (context) => CameraPage(),
          PreviewPage.routeName: (context) => PreviewPage(),
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
