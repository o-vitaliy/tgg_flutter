import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tgg/blocs/theme_bloc.dart';

class HeadToHeadTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        widthFactor: 0.8,
        child: RaisedButton(
          onPressed: () => _changeAppTheme(),
          child: Text(
            "Change app theme",
          ),
          textColor: Colors.white,
        ));
  }

  void _changeAppTheme() => bloc.colorGreen();
}
