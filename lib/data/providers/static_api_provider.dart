import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../../models/blueprint_model.dart';

class StaticApiProvider {
  Client client = Client();
  final _baseUrl = 'https://test-play.thegogame.com/static/assets';

  Future<BlueprintModel> fetchBlueprint() async {
    print("fetchBlueprint");
    final response = await client.get("$_baseUrl/blueprints/gogame.json");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return BlueprintModel.fromJsonMap(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
