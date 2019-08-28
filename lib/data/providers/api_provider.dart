import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:tgg/models/game/game_info.dart';
import 'package:tgg/models/game/game_response.dart';

class ApiProvider {
  Client client = Client();
  final _baseUrl = 'https://test-play.thegogame.com/api';

  Future<GameInfo> fetchGameInfo(String code) async {
    final url =
        "$_baseUrl/objects/playthroughs?pin=$code&is_active=true&is_archived=false&sideload=game.flavors&_=${DateTime.now().millisecondsSinceEpoch}";
    final response = await client.get(url);
    print(url);
    print(response.body.toString());
    if (response.statusCode == 200) {
      return GameInfo.fromJsonMap(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}

final apiProvider = ApiProvider();
