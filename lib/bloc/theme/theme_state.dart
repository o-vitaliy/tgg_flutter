import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class ThemeChangeState extends Equatable {
  ThemeChangeState([List props = const []]);
}

class ThemeChangedState extends ThemeChangeState {
  final ThemeData theme;

  ThemeChangedState({@required this.theme}) : super([theme]);

  @override
  List<Object> get props => [theme];

  @override
  String toString() => 'ThemeChangedState { theme: $theme }';
}
