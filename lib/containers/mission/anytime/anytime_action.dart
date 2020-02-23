import 'package:meta/meta.dart';
import 'package:tgg/containers/mission/base/mission_action.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

@immutable
class AnytimeLoadedAction {
  final List<Mission> missions;

  AnytimeLoadedAction(this.missions);
}

class AnytimeStartLoadAction extends MissionStartLoadAction {
  AnytimeStartLoadAction(List<Waypoint> waypoints) : super(waypoints);
}

class AnytimeLoadWaypointAction extends LoadMissionWaypointAction {
  AnytimeLoadWaypointAction(String missionId) : super(missionId);
}

class AnytimeLoadedWaypointAction extends LoadedMissionWaypointAction {
  AnytimeLoadedWaypointAction(Waypoint waypoint) : super(waypoint);
}

class AnytimeChangeListLoadingStateAction {
  final bool loading;

  AnytimeChangeListLoadingStateAction(this.loading);
}

class AnytimeChangeWaipointLoadingStateAction {
  final bool loading;

  AnytimeChangeWaipointLoadingStateAction(this.loading);
}
