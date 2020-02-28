import 'dart:async';

import 'package:meta/meta.dart';

import 'http_helper.dart';

class ApiProvider {
  String token;
  final _baseUrl = 'https://bc2-api-stage.thegogame.com/api/v2.0';

  Future<String> login(String code) async {
    final url = "$_baseUrl/play/playthroughs/login/";

    Map map = {
      'pin': code,
    };
    return apiRequest(url, params: map);
  }

  Future<String> playthroughs(String playthroughId) async {
    final url = "$_baseUrl/play/playthroughs/$playthroughId/";
    return apiRequest(url, token: token, method: httpMethod.get);
  }

  Future<String> activeWaypoints() async {
    final url = "$_baseUrl/play/waypoints/my_active_waypoints/";
    return apiRequest(url, token: token, method: httpMethod.get);
  }

  Future<String> availableMissions(String teamId, String mode) async {
    final url = "$_baseUrl/play/teams/$teamId/available_missions/?mode=$mode";
    return apiRequest(url, token: token, method: httpMethod.get);
  }

  Future<String> waypointTriggerAction({
    waypointId: String,
    values: Map,
  }) async {
    final url = "$_baseUrl/play/waypoints/$waypointId/trigger_action/";
    return apiRequest(url, token: token, params: values);
  }

  Future<String> team({teamId: String}) async {
    final url = "$_baseUrl/play/teams/$teamId/trigger_action/";
    return apiRequest(url, token: token, method: httpMethod.get);
  }

  Future<String> teamTriggerAction({
    teamId: String,
    values: Map,
  }) async {
    final url = "$_baseUrl/play/teams/$teamId/trigger_action/";
    return apiRequest(url, token: token, params: values);
  }

  Future<String> location({
    String teamId,
    double longitude,
    double latitude,
    int accuracy,
  }) async {
    final url = "$_baseUrl/play/teams/$teamId/update_location/";

    Map map = {
      'location': {'lng': longitude, 'lat': latitude},
      'located_at': DateTime.now().toIso8601String(),
      'accuracy': accuracy
    };

    return apiRequest(url, token: token, params: map);
  }

  Future<String> createMedia({@required Map values}) async {
    final url = "$_baseUrl/media/";
    return apiRequest(url, token: token, params: values);
  }

  Future<String> putMedia({@required String id, @required Map values}) async {
    final url = "$_baseUrl/media/$id/";
    return apiRequest(url,
        token: token, params: values, method: httpMethod.put);
  }

  Future<String> getFlavor(String blueprintId) {
    final url = "$_baseUrl/flavors/entries/$blueprintId/";
    return apiRequest(url, token: token, method: httpMethod.get);
  }

  Future<String> getGameFlavor(String gameId) {
    final url = "$_baseUrl/games/$gameId/flavor/";
    return apiRequest(url, token: token, method: httpMethod.get);
  }

  Future<String> getRouting(String gameId) {
    final url = "$_baseUrl/games/$gameId/routing/";
    return apiRequest(url, token: token, method: httpMethod.get);
  }
}
