import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tgg/models/models.dart';

enum httpMethod { post, put }

class ApiProvider {
  String token;
  final _baseUrl = 'https://bc2-api-stage.thegogame.com/api/v2.0';

  Future<LoginResponse> login(String code) async {
    final url = "$_baseUrl/playthroughs/login/";

    Map map = {
      'pin': code,
    };
    final response = await apiRequest(url, map);
    if (response != null) {
      try {
        return LoginResponse.fromJsonMap(json.decode(response));
      } catch (e) {
        print(e);
      }
    }
    return null;
  }

  void location({
    String teamId,
    double longitude,
    double latitude,
    int accuracy,
  }) async {
    final url = "$_baseUrl/teams/$teamId/update_location/";

    Map map = {
      'location': {'lng': longitude, 'lat': latitude},
      'located_at': DateTime.now().toUtc().toString(),
      'accuracy': accuracy
    };
    try {
      await apiRequest(url, map);
    } catch (e) {
      print(e);
    }
  }

  Future<String> apiRequest(String url, Map jsonMap,
      {httpMethod method = httpMethod.post}) async {
    HttpClient httpClient = HttpClient();
    HttpClientRequest request =
        await sendClientRequest(httpClient, Uri.parse(url), method);
    request.headers.set('content-type', 'application/json');
    if (token != null) request.headers.set('Authorization', 'Token $token');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    try {
      final reply = await response.transform(utf8.decoder).join();
      if (response.statusCode < 400) {
        return reply;
      } else {
        print("network error: $reply");
        if (isJson(reply)) {
          final String errors = Map<String, dynamic>.from(json.decode(reply))
              .values
              .expand((v) => List<String>.from(v.map((e) => e as String)))
              .join(", ");
          throw ArgumentError(errors);
        } else {
          throw ArgumentError("Internal server error");
        }
      }
    } finally {
      httpClient.close();
    }
  }

  Future<HttpClientRequest> sendClientRequest(
      HttpClient httpClient, Uri url, httpMethod method) {
    switch (method) {
      case httpMethod.post:
        return httpClient.postUrl(url);
      case httpMethod.put:
        return httpClient.putUrl(url);
      default:
        throw Exception("missed implemention of $method");
    }
  }

  bool isJson(String response) {
    try {
      json.decode(response);
      return true;
    } catch (_) {
      return false;
    }
  }
}

final apiProvider = ApiProvider();
