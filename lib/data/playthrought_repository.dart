import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/models.dart';

class PlaythroughRepo {
  final ApiProvider apiProvider;

  PlaythroughRepo({@required this.apiProvider});

  Future<Playthrough> getPlaythrough(String playthroughId) async {
    final response = await apiProvider.playthroughs(playthroughId);
    final map = json.decode(response);
    return Playthrough.fromJsonMap(map);
  }
}
