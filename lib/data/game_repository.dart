import 'package:meta/meta.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/prefs_provider.dart';
import 'package:tgg/models/game/game_info.dart';

class GameRepository {
  GameInfo _gameInfoCache;

  Future<GameInfo> getGame() async {
    if (_gameInfoCache == null) {
      _gameInfoCache = await prefsProvider
          .getGameCode()
          .then((code) => code != null ? loadGame(code: code) : null);
    }
    return _gameInfoCache;
  }

  Future<GameInfo> loadGame({@required String code}) async {
    _gameInfoCache = await apiProvider.fetchGameInfo(code);
    await prefsProvider.setGameCode(code);
    return _gameInfoCache;
  }
}
