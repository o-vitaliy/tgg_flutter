import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:tgg/models/modes.dart';

@immutable
class RoutingState {
  final RouteMode selectedMode;
  final List<RouteMode> modes;

  RoutingState({
    @required this.selectedMode,
    this.modes,
  });

  RoutingState copyWith({
    Optional<RouteMode> selectedMode,
    List<RouteMode> modes,
  }) {
    return RoutingState(
      selectedMode:
          selectedMode != null ? selectedMode.orNull : this.selectedMode,
      modes: modes ?? this.modes,
    );
  }

  factory RoutingState.initial(List<RouteMode> modes) {
    return RoutingState(selectedMode: RouteMode.home(), modes: modes);
  }
}
