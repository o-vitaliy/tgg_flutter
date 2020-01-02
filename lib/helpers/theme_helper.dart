import 'package:flutter/material.dart';
import 'package:tgg/ui/colors.dart';

ThemeData getDefaultTheme() => buildTheme(ORANGE_COLORS, Colors.orange.shade100);

ThemeData buildTheme(MaterialColor primarySwatch, Color disabledColor) =>
    ThemeData(
      primarySwatch: primarySwatch,
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(),
        textTheme: ButtonTextTheme.normal,
        disabledColor: disabledColor,
      ),
    );
