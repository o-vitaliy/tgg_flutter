import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/data/game_repository.dart';
import 'package:tgg/data/simple_bloc_delegate.dart';
import 'package:tgg/ui/auth/login_page.dart';
import 'package:tgg/ui/home.dart';

import 'bloc/auth/authentication.dart';
import 'bloc/auth/login.dart';
import 'bloc/theme/theme.dart';
import 'ui/splash.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final gameRepo = GameRepo();

  final themeBloc = ThemeBloc(gameRepository: gameRepo);
  final authBloc = AuthenticationBloc(gameRepo: gameRepo, themeBloc: themeBloc);
  final loginBloc = LoginBloc(gameRepo: gameRepo, authenticationBloc: authBloc);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBloc>(builder: (context) {
          return authBloc..dispatch(AppStarted());
        }),
        BlocProvider<ThemeBloc>(builder: (context) => themeBloc),
        BlocProvider<LoginBloc>(builder: (context) => loginBloc),
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
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
              // ignore: missing_return
              builder: (context, authState) {
            if (authState is AuthenticationUninitialized)
              return SplashPage();
            else if (authState is AuthenticationAuthenticated)
              return HomePage();
            else if (authState is AuthenticationUnauthenticated)
              return LoginPage(gameRepository: gameRepo);
          })
          /*initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginPage(gameRepository: gameRepo),
          '/onbording': (context) => OnBoardingPage(),
          ROUTE_MAIN: (context) => HomePage(),
          ROUTE_BONUS_CAMERA: (context) => CameraPage(),
        },*/
          );
    });
  }
}
