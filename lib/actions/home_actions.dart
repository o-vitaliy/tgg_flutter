import 'package:tgg/models/modes.dart';

class InitRouteModeAction {
  final List<RouteMode> modes;

  InitRouteModeAction(this.modes);
}

class ChangeRouteModeAction {
  final RouteMode selectedMode;

  ChangeRouteModeAction(this.selectedMode);
}
