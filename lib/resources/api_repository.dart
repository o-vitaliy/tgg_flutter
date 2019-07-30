import 'dart:async';

import 'package:tgg/models/game/game_info.dart';
import 'package:tgg/resources/api_provider.dart';

class ApiRepository {
  final apiProvider = ApiProvider();

  Future<GameInfo> fetchGameInfo(String code) => apiProvider.fetchGameInfo(code);
}
