import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/statics_repo.dart';
import 'package:tgg/helpers/map_utils.dart';
import 'package:tgg/models/models.dart';

class PlaythroughRepo {
  final ApiProvider apiProvider;
  final StaticRepo staticRepo;

  PlaythroughRepo({@required this.apiProvider, @required this.staticRepo});

  Future<Game> getGame() async {}

  Future<Playthrough> getPlaythrough(String playthroughId) async {
    final response = await apiProvider.playthroughs(playthroughId);
    final map = json.decode(response);
    final blueprint = await staticRepo.getBluePrint();
    map["game"]["blueprint"] = merge(map["game"]["blueprint"], blueprint);
    return Playthrough.fromJsonMap(map);
  }
}
