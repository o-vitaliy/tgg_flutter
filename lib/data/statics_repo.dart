import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tgg/data/providers/static_api_provider.dart';

class StaticRepo {
  final StaticApiProvider apiProvider;
  Map<String, dynamic> _blueprint;
  Map<String, dynamic> _flavor;

  StaticRepo({@required this. apiProvider});

  Future<Map<String, dynamic>> getBluePrint() async {
    if (_blueprint == null) {
      String response = await apiProvider.fetchBlueprint();
      _blueprint = json.decode(response);
    }
    return _blueprint;
  }

  Future<Map<String, dynamic>> getFlavor() async {
    if (_flavor == null) {
      String response = await apiProvider.fetchFlavor();
      _flavor = json.decode(response);
    }
    return _flavor;
  }
}
