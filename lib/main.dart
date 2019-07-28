import 'package:flutter/material.dart';
import 'package:tgg/ui/home.dart';

import 'ui/onbording.dart';
import 'ui/splash.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PageViewIndicators Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => SplashPage(),
        '/onbording': (context) => OnBoardingPage(),
        '/main': (context) => HomePage(),
      },
    );
  }
}
