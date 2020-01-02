import 'package:flutter/material.dart';
import 'package:tgg/models/modes.dart';

@immutable
class HomePageState {
  final RouteMode selectedMode;
  final List<RouteMode> modes;

  HomePageState({
    @required this.selectedMode,
    this.modes,
  });

  HomePageState copyWith({
    RouteMode selectedMode,
    List<RouteMode> modes,
  }) {
    return HomePageState(
      selectedMode: selectedMode ?? this.selectedMode,
      modes: modes ?? this.modes,
    );
  }

  factory HomePageState.initial(List<RouteMode> modes) {
    return HomePageState(selectedMode: modes.first, modes: modes);
  }
}
