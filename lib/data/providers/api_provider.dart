import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' show Client;
import 'package:tgg/models/models.dart';

class ApiProvider {
  Client client = Client();
  final _baseUrl = 'https://bc2-api-stage.thegogame.com/api/v2.0/playthroughs';

  Future<LoginResponse> login(String code) async {
    final url = "$_baseUrl/login/";

    Map map = {
      'pin': code,
    };
    final response = await apiRequest(url, map);
    return LoginResponse.fromJsonMap(json.decode(response));
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    try {
      final reply = await response.transform(utf8.decoder).join();
      if (response.statusCode < 400) {
        return reply;
      } else {
        final String errors = Map<String, dynamic>.from(json.decode(reply))
            .values
            .expand((v) => List<String>.from(v.map((e) => e as String)))
            .join(", ");
        throw ArgumentError(errors);
      }
    } finally {
      httpClient.close();
    }
  }
}

final apiProvider = ApiProvider();
