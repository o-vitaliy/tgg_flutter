import 'dart:async';

import 'package:tgg/models/modes.dart';

class RouteLoadAction {
  final String gameId;
  final DateTime playthoughStartedAt;

  RouteLoadAction(this.gameId, this.playthoughStartedAt);
}

class RouteUpdateModesAction {
  final List<RouteMode> modes;

  RouteUpdateModesAction(this.modes);
}

class RouteSaveModesAction {
  final List<RouteMode> modes;

  RouteSaveModesAction(this.modes);
}

class RouteSaveTabAvailability {
  final bool hasAnyTime;
  final bool hasBonus;

  RouteSaveTabAvailability(this.hasAnyTime, this.hasBonus);
}

class RouteSaveTimerAction {
  final List<Timer> timers;

  RouteSaveTimerAction(this.timers);
}

class RouteChangeCurrentModeAction {
  final RouteMode selectedMode;

  RouteChangeCurrentModeAction(this.selectedMode);
}
