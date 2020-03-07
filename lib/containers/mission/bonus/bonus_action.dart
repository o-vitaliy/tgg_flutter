import 'package:meta/meta.dart';
import 'package:tgg/containers/mission/base/mission_action.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

@immutable
class BonusLoadedAction {
  final List<Mission> missions;

  BonusLoadedAction(this.missions);
}

class BonusStartLoadAction extends MissionStartLoadAction {
  BonusStartLoadAction() : super();
}

class BonusLoadWaypointAction extends LoadMissionWaypointAction {
  BonusLoadWaypointAction(String missionId) : super(missionId);
}

class BonusLoadedWaypointAction extends LoadedMissionWaypointAction {
  BonusLoadedWaypointAction(Waypoint waypoint) : super(waypoint);
}

class BonusChangeListLoadingStateAction {
  final bool loading;

  BonusChangeListLoadingStateAction(this.loading);
}

class BonusChangeWaipointLoadingStateAction {
  final bool loading;

  BonusChangeWaipointLoadingStateAction(this.loading);
}
