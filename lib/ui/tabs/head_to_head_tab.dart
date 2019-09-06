import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tgg/bloc/theme/theme.dart';

class HeadToHeadTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);
    return Align(
        widthFactor: 0.8,
        child: RaisedButton(
          onPressed: () => _changeAppTheme(themeBloc),
          child: Text(
            "Set default app theme",
          ),
          textColor: Colors.white,
        ));
  }

  void _changeAppTheme(ThemeBloc bloc) {
    bloc.dispatch(ThemeChanged(theme: ThemeBloc.defaultTheme()));
  }
}
