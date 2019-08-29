import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/data/game_repository.dart';
import 'package:tgg/data/simple_bloc_delegate.dart';
import 'package:tgg/ui/auth/login_page.dart';
import 'package:tgg/ui/home.dart';
import 'package:tgg/ui/pages/camera_page.dart';
import 'package:tgg/ui/routes.dart';

import 'bloc/auth/authentication.dart';
import 'bloc/theme/theme.dart';
import 'ui/onbording.dart';
import 'ui/splash.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final gameRepo = GameRepo();

  final themeBloc = ThemeBloc(gameRepository: gameRepo);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(builder: (context) {
          return AuthenticationBloc(gameRepo: gameRepo, themeBloc: themeBloc)
            ..dispatch(AppStarted());
        }),
        BlocProvider<ThemeBloc>(builder: (context) => themeBloc),
      ],
      child: App(gameRepo: gameRepo),
    ),
  );
}

class App extends StatelessWidget {
  final GameRepo gameRepo;

  const App({Key key, this.gameRepo})
      : assert(gameRepo != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeChangeState>(builder: (context, state) {
      return MaterialApp(
        title: 'Tgg Demo',
        theme: (state is ThemeChangedState) ? state.theme : ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(gameRepository: gameRepo),
          '/onbording': (context) => OnBoardingPage(),
          ROUTE_MAIN: (context) => HomePage(),
          ROUTE_BONUS_CAMERA: (context) => CameraPage(),
        },
      );
    });
  }
}
