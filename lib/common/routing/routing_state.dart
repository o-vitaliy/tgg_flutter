import 'package:flutter/material.dart';
import 'package:quiver/core.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

@immutable
class RoutingState {
  final RouteMode selectedMode;
  final List<RouteMode> modes;

  RoutingState({
    @required this.selectedMode,
    @required this.modes,
  });

  RouteMode findMode(Mode mode) {
    return modes.firstWhere((m) => m.name == ModeHelper.to(mode),
        orElse: () => null);
  }

  List<RouteMode> getModesFiltered(
    bool hasAnytimes,
    bool hasBonus,
  ) {
    final filtered = modes.toList();
    if (!hasAnytimes) {
      filtered.removeWhere((m) => m.name == ModeHelper.to(Mode.anytime));
    }
    if (!hasBonus) {
      filtered.removeWhere((m) => m.name == ModeHelper.to(Mode.camera));
    }

    filtered.removeWhere((m) => !m.enabled);
    return filtered;
  }

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
