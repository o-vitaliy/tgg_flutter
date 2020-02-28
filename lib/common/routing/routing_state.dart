import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:quiver/core.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

@immutable
class RoutingState {
  final RouteMode selectedMode;
  final List<RouteMode> modes;
  final bool hasAnytimes;
  final bool hasBonus;
  final List<Timer> timers;

  RoutingState(
      {@required this.selectedMode,
      @required this.modes,
      @required this.hasAnytimes,
      @required this.hasBonus,
      @required this.timers});

  RouteMode findMode(Mode mode) {
    return modes.firstWhere((m) => m.name == ModeHelper.to(mode),
        orElse: () => null);
  }

  List<RouteMode> get activeModes {
    final filtered = modes.toList();
    if (hasAnytimes == null || !hasAnytimes) {
      filtered.removeWhere((m) => m.name == ModeHelper.to(Mode.anytime));
    }
    if (hasBonus == null || !hasBonus) {
      filtered.removeWhere((m) => m.name == ModeHelper.to(Mode.camera));
    }

    filtered.removeWhere((m) => !m.enabled);
    return filtered;
  }

  RoutingState copyWith({
    Optional<RouteMode> selectedMode,
    List<RouteMode> modes,
    Value<bool> hasAnytimes,
    Value<bool> hasBonus,
    List<Timer> timers,
  }) {
    if (timers != null) {
      this.timers?.forEach((timer) => timer.cancel());
    }
    return RoutingState(
      selectedMode:
          selectedMode != null ? selectedMode.orNull : this.selectedMode,
      modes: modes ?? this.modes,
      hasAnytimes: hasAnytimes != null ? hasAnytimes.value : this.hasAnytimes,
      hasBonus: hasBonus != null ? hasBonus.value : this.hasBonus,
      timers: timers ?? this.timers,
    );
  }

  factory RoutingState.initial(List<RouteMode> modes) {
    return RoutingState(
        selectedMode: RouteMode.home(),
        modes: [],
        hasAnytimes: null,
        hasBonus: null,
        timers: null);
  }
}
