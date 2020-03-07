import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/waypoint_repository.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';

import 'base_mission_repo.dart';

class AnytimeRepo extends BaseMissionRepo {
  AnytimeRepo({
    ApiProvider apiProvider,
    WaypointsRepo waypointsRepo,
  }) : super(apiProvider: apiProvider, waypointsRepo: waypointsRepo);

  @override
  Mode get mode => AnytimeMode();
}
