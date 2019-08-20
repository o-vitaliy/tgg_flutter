import 'package:flutter/material.dart';
import 'package:tgg/ui/home.dart';
import 'package:tgg/ui/log_in.dart';

import 'blocs/login_provider.dart';
import 'blocs/theme_bloc.dart';
import 'ui/onbording.dart';
import 'ui/splash.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  ThemeBloc _themeBloc;

  @override
  void initState() {
    super.initState();
    _themeBloc = bloc;
  }

  @override
  void dispose() {
    super.dispose();
    _themeBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _themeBloc.outTheme,
      builder: (context, AsyncSnapshot<ThemeData> snapshot) => MaterialApp(
        title: 'Tgg Demo',
        theme: snapshot.hasData ? snapshot.data : ThemeData(),
        initialRoute: '/',
        routes: {
          '/': (context) => SplashPage(),
          '/login': (context) => LoginProvider(child: LogInPage()),
          '/onbording': (context) => OnBoardingPage(),
          '/main': (context) => HomePage(),
        },
      ),
    );
  }
}
