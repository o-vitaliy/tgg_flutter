import 'package:flutter/material.dart';
import 'package:tgg/blocs/userprefs_bloc.dart';
import 'package:tgg/ui/colors.dart';

class SplashPage extends StatelessWidget {

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
}
