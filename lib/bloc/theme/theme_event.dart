import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class ThemeChangeEvent extends Equatable {
  ThemeChangeEvent([List props = const []]);
}

class ThemeChanged extends ThemeChangeEvent {
  final ThemeData theme;

  ThemeChanged({
    @required this.theme,
  }) : super([theme]);

  @override
  List<Object> get props => [theme];

  @override
  String toString() => 'ThemeChanged { theme: $theme }';
}
