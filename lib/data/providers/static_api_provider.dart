import 'dart:async';

import 'http_helper.dart';

class StaticApiProvider {
  final _baseUrl = 'https://test-play.thegogame.com/static/assets';

  Future<String> fetchBlueprint() async {
    final url = "$_baseUrl/blueprints/gogame.json";
    return apiRequest(url, method: httpMethod.get);
  }

}