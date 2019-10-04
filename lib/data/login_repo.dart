import 'package:meta/meta.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/models.dart';

import 'providers/prefs_provider.dart';

class LoginRepo {
  LoginResponse loginResponse;

  Future<LoginResponse> loadLoginData({@required String code}) async {
    await prefsProvider.setGameCode(code);
    loginResponse = await apiProvider.login(code);
    apiProvider.token = loginResponse.token;
    return loginResponse;
  }

  Future<LoginResponse> getLoginResponse() async {
    if (loginResponse == null) {
      final gameCode = await prefsProvider.getGameCode();
      if (gameCode != null) {
        await loadLoginData(code: gameCode);
      }
    }
    return loginResponse;
  }

  void removeGame() async {
    loginResponse = null;
    apiProvider.token = null;
    prefsProvider.setGameCode(null);
  }
}
