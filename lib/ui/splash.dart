import 'package:flutter/material.dart';

import '../blocs/onbording_bloc.dart';

class SplashPage extends StatefulWidget {
  @override
  State createState() => new SplashState();
}

class SplashState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    bloc.isOnbordingSeen
        .delay(Duration(seconds: 3))
        .doOnData((data) => bloc.setOnbordingSeen())
        .listen((seen) => _moveNext(seen), onError: (e) => print(e));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0XFFF47421),
        child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icon180.png'),
            ),
          ),
        ));
  }

  void _moveNext(bool seen) {
    print(seen);
    if (seen)
      _showMain();
    else
      _showOnBording();
  }

  void _showMain() {
    print("to main");
    Navigator.pushNamed(context, '/main');
  }

  void _showOnBording() {
    print("to onbording");
    Navigator.pushNamed(context, '/onbording');
  }
}
