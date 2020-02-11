import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/routing.dart';

class RoutingRepo {
  final ApiProvider apiProvider;

  RoutingRepo({@required this.apiProvider});

  Future<Routing> getRouting(String gameId) async {
    final response = await apiProvider.getRouting(gameId);
    final map = json.decode(response);
    return Routing.fromJsonMap(map);
  }
}
