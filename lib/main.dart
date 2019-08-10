import 'package:flutter/material.dart';
import 'package:tgg/ui/colors.dart';
import 'package:tgg/ui/home.dart';
import 'package:tgg/ui/log_in.dart';

import 'blocs/login_provider.dart';
import 'ui/onbording.dart';
import 'ui/splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageViewIndicators Demo',
      theme: ThemeData(
        primarySwatch: ORANGE_COLORS,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.normal,
          disabledColor: Colors.orange.shade100,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/login': (context) => LoginProvider(child: LogInPage()),
        '/onbording': (context) => OnBoardingPage(),
        '/main': (context) => HomePage(),
      },
    );
  }
}
