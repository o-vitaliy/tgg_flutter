import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/helpers/map_utils.dart';

class StaticRepo {
  final ApiProvider apiProvider;

  StaticRepo({@required this.apiProvider});

  Future<Map<String, dynamic>> getFlavor(
      String blueprintId, String gameId) async {
    final _flavor = await _loadFlavor(blueprintId)
        .zipWith(_getGameFlavor(gameId), (f1, f2) => merge(f1, f2))
        .first;

    return _flavor;
  }

  Observable<Map<String, dynamic>> _loadFlavor(String blueprintId) {
    return Observable.fromFuture(apiProvider.getFlavor(blueprintId))
        .map((r) => json.decode(r));
  }

  Observable<Map<String, dynamic>> _getGameFlavor(String blueprintId) {
    return Observable.fromFuture(apiProvider.getGameFlavor(blueprintId))
        .map((r) => json.decode(r))
        .map((r) => r["entries"]);
  }
}
