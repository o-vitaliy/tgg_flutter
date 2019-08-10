import 'package:flutter/material.dart';
import 'package:tgg/blocs/userprefs_bloc.dart';
import 'package:tgg/ui/colors.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() => new SplashState();
}

class SplashState extends State<SplashPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (AppLifecycleState.resumed == state) {
      startTimer();
    }
  }

  void startTimer() {
    bloc.isLoggedIn
        .delay(Duration(seconds: 2))
        .listen((seen) => _moveNext(seen), onError: (e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(ORANGE),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icon180.png'),
            ),
          ),
        ));
  }

  void _moveNext(bool seen) {
    if (seen)
      _showMain();
    else
      _login();
  }

  void _showMain() {
    print("to main");
    Navigator.pushReplacementNamed(context, '/main');
  }

  void _login() {
    Navigator.pushReplacementNamed(context, '/login');
  }
}
