import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/ui/colors.dart';

class ThemeBloc {
  final _theme = BehaviorSubject<ThemeData>(seedValue: _default());

  Function(ThemeData) get inTheme => _theme.sink.add;

  Stream<ThemeData> get outTheme => _theme.stream;

  void colorGreen() => inTheme(_build(Colors.green, Colors.green.shade100));

  dispose() {
    _theme.close();
  }

  static ThemeData _default() => _build(ORANGE_COLORS, Colors.orange.shade100);

  static ThemeData _build(primarySwatch, disabledColor) => ThemeData(
        primarySwatch: primarySwatch,
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(),
          textTheme: ButtonTextTheme.normal,
          disabledColor: disabledColor,
        ),
      );
}

final bloc = ThemeBloc();
