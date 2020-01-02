import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tgg/data/playthrought_repository.dart';
import 'package:tgg/ui/colors.dart';

import 'theme.dart';

class ThemeBloc extends Bloc<ThemeChangeEvent, ThemeChangeState> {
  final PlaythroughRepo gameRepository;

  ThemeBloc({@required this.gameRepository}) : assert(gameRepository != null);

  @override
  ThemeChangeState get initialState => ThemeChangedState(theme: defaultTheme());

  @override
  Stream<ThemeChangeState> mapEventToState(ThemeChangeEvent event) async* {
    if (event is ThemeChanged) {
      yield ThemeChangedState(theme: event.theme);
    }
  }

  static ThemeData defaultTheme() =>
      buildTheme(ORANGE_COLORS, Colors.orange.shade100);

  static ThemeData buildTheme(primarySwatch, disabledColor) => ThemeData(
        primarySwatch: primarySwatch,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.normal,
          disabledColor: disabledColor,
        ),
      );
}
