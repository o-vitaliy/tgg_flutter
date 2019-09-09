import 'package:meta/meta.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/prefs_provider.dart';
import 'package:tgg/models/models.dart';

class GameRepo {
  Game _gameCache;

  Future<Game> getGame() async {
    if (_gameCache == null) {
      _gameCache = await prefsProvider
          .getGameCode()
          .then((code) => code != null ? loadGame(code: code) : null);
    }
    return _gameCache;
  }

  Future<Game> loadGame({@required String code}) async {
    final login = await apiProvider.login(code);
    if (login != null) {
      _gameCache = login.team.playthrough.game;
      await prefsProvider.setGameCode(code);
      return _gameCache;
    } else {
      return null;
    }
  }

  Future removeGame() async {
    await prefsProvider.setGameCode(null);
  }
}
