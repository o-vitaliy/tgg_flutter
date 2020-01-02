import 'package:flutter/material.dart';

class UpdateThemeAction {
  final MaterialColor primarySwatch;
  final Color disabledColor;

  UpdateThemeAction(this.primarySwatch, this.disabledColor);

  @override
  String toString() {
    return 'UpdateThemeAction{primarySwatch: $primarySwatch, disabledColor: $disabledColor}';
  }
}

class DefaultThemeAction {}
