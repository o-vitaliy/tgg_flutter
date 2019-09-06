import 'dart:async';

import '../models/blueprint_model.dart';
import '../data/providers/static_api_provider.dart';

class StaticDataRepository {
  final staticApiProvider = StaticApiProvider();

  Future<BlueprintModel> fetchBlueprint() => staticApiProvider.fetchBlueprint();
}
