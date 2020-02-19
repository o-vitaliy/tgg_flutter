import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/helpers/map_utils.dart';

const defaultFlavor = "gogame";

class StaticRepo {
  final ApiProvider apiProvider;
  Map<String, dynamic> _flavor;

  StaticRepo({@required this.apiProvider});

  Future<Map<String, dynamic>> getFlavor(String blueprintId) async {
    if (_flavor == null) {
      if (blueprintId == defaultFlavor) {
        _flavor = await loadFlavor(defaultFlavor).first;
      } else {
        _flavor = await loadFlavor(defaultFlavor)
            .zipWith(loadFlavor(blueprintId), (f1, f2) => merge(f1, f2))
            .first;
      }
    }
    return _flavor;
  }

  Observable<Map<String, dynamic>> loadFlavor(String blueprintId) {
    return Observable.fromFuture(apiProvider.getFlavor(blueprintId))
        .map((r) => json.decode(r));
  }
}
