import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/waypoint_repository.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

abstract class BaseMissionRepo {
  final ApiProvider apiProvider;
  final WaypointsRepo waypointsRepo;

  Mode get mode;

  BaseMissionRepo({
    @required this.apiProvider,
    @required this.waypointsRepo,
  });

  Future<List<Mission>> getMissions(String teamId) async {
    final response = await apiProvider.availableMissions(
      teamId,
      ModeHelper.to(mode),
    );
    final map = json.decode(response);
    final mapped = map.map((w) => Mission.fromJsonMap(w)).toList();

    return List<Mission>.from(mapped, growable: false);
  }

  Future startMission(String teamId, String missionId) async {
    final location = await waypointsRepo.locationProvider.getLocation();
    final result = await apiProvider.teamTriggerAction(teamId: teamId, values: {
      "name": "queue",
      "params": {
        "mission_id": missionId,
        "location_fix": waypointsRepo.locationProvider.toFix(location),
      }
    });
    return result;
  }
}
