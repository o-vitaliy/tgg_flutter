import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class ThemeChangeEvent extends Equatable {
  ThemeChangeEvent([List props = const []]) : super(props);
}

class ThemeChanged extends ThemeChangeEvent {
  final ThemeData theme;

  ThemeChanged({
    @required this.theme,
  }) : super([theme]);

  @override
  String toString() => 'ThemeChanged { theme: $theme }';
}
