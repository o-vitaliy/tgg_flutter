import 'package:tgg/containers/mission/anytime/anytime_action.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

//todo refactor
abstract class Mode {
  const Mode();

  String get name;

  List getAfterSubmitActions(Waypoint waypoint) {
    return [];
  }

  static const String main = "main";
  static const String camera = "camera";
  static const String anytime = "anytime";
  static const String h2h = "head_to_head";

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mode && runtimeType == other.runtimeType && name == other.name;

  @override
  int get hashCode => name.hashCode;
}

class MainMode extends Mode {
  const MainMode() : super();

  @override
  String get name => Mode.main;

  List getAfterSubmitActions(Waypoint waypoint) {
    return [WaypointSwitchToNextAction(this)];
  }
}

class CameraMode extends Mode {
  const CameraMode() : super();

  @override
  String get name => Mode.camera;
}

class AnytimeMode extends Mode {
  const AnytimeMode() : super();

  @override
  String get name => Mode.anytime;

  List getAfterSubmitActions(Waypoint waypoint) {
    return [WaypointRemoveAction(waypoint.id), AnytimeStartLoadAction()];
  }
}

class H2HMode extends Mode {
  const H2HMode() : super();

  @override
  String get name => Mode.h2h;
}

class ModeHelper {
  static Mode fromString(String name) {
    switch (name) {
      case Mode.main:
        return MainMode();
      case Mode.camera:
        return CameraMode();
      case Mode.anytime:
        return AnytimeMode();
      case Mode.h2h:
        return H2HMode();

      default:
        throw ArgumentError("unsuppored mode $name");
    }
  }
}
