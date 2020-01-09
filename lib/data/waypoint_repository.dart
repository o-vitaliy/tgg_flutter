import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/waypoints/waypoint.dart';

class WaypointsRepo {
  final ApiProvider apiProvider;

  WaypointsRepo({@required this.apiProvider});

  Future<List<Waypoint>> getActiveWaypoints() async {
    final response = await apiProvider.activeWaypoints();
    final map = json.decode(response);
    final mapped = map.map((w) => Waypoint.fromJsonMap(w));
    return List<Waypoint>.from(mapped);
  }
}
