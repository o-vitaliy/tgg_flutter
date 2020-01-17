import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
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
    Optional<RouteMode> selectedMode,
    List<RouteMode> modes,
  }) {
    return HomePageState(
      selectedMode:
          selectedMode != null ? selectedMode.orNull : this.selectedMode,
      modes: modes ?? this.modes,
    );
  }

  factory HomePageState.initial(List<RouteMode> modes) {
    return HomePageState(selectedMode: RouteMode.home(), modes: modes);
  }
}
