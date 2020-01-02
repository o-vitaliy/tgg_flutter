import 'dart:async';

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

  Future<String> location({
    String teamId,
    double longitude,
    double latitude,
    int accuracy,
  }) async {
    final url = "$_baseUrl/play/teams/$teamId/update_location/";

    Map map = {
      'location': {'lng': longitude, 'lat': latitude},
      'located_at': DateTime.now().toUtc().toString(),
      'accuracy': accuracy
    };

    return apiRequest(url, token: token, params: map);
  }
}

final apiProvider = ApiProvider();