import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/helpers/map_utils.dart';

class StaticRepo {
  final ApiProvider apiProvider;

  Map<String, Map<String, dynamic>> _cached = Map();

  StaticRepo({@required this.apiProvider});

  Future<Map<String, dynamic>> getFlavor(String blueprintId) {
    return _loadFlavor(blueprintId).first;
  }

  Future<Map<String, dynamic>> getGameFlavor(
      String blueprintId, String gameId) async {
    final _flavor = await _loadFlavor(blueprintId)
        .zipWith(_getGameFlavor(gameId), (f1, f2) => merge(f1, f2))
        .first;

    return _flavor;
  }

  Observable<Map<String, dynamic>> _loadFlavor(final String blueprintId) {
    final cached = _cached[blueprintId];
    if (cached != null) return Observable.just(cached);
    return Observable.fromFuture(apiProvider.getFlavor(blueprintId))
        .map((r) => json.decode(r))
        .doOnData((data) => _cached[blueprintId] = data)
        .map((event) => event as Map<String, dynamic>);
  }

  Observable<Map<String, dynamic>> _getGameFlavor(final String gameId) {
    return Observable.fromFuture(apiProvider.getGameFlavor(gameId))
        .map((r) => json.decode(r))
        .map((r) => r["entries"]);
  }
}
