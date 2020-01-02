import 'package:meta/meta.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/models.dart';

import 'providers/prefs_provider.dart';

class LoginRepo {
  LoginResponse loginResponse;

  Future<LoginResponse> login({@required String code}) async {
    loginResponse = await apiProvider.login(code);
    await prefsProvider.setGameCode(code);
    apiProvider.token = loginResponse.token;
    return loginResponse;
  }

  Future<LoginResponse> reLogin() async {
    final code = await prefsProvider.getGameCode();
    if (code != null) {
      try {
        apiProvider.token = null;
        loginResponse = await apiProvider.login(code);
        apiProvider.token = loginResponse.token;
        return loginResponse;
      } catch (error) {
        await prefsProvider.setGameCode(null);
        throw error;
      }
    }
    return null;
  }

  Future<LoginResponse> getLoginResponse() async {
    if (loginResponse == null) {
      final gameCode = await prefsProvider.getGameCode();
      if (gameCode != null) {
        await login(code: gameCode);
      }
    }
    return loginResponse;
  }

  Future removeGame() async {
    loginResponse = null;
    apiProvider.token = null;
    prefsProvider.setGameCode(null);
  }
}

final logInRepo = LoginRepo();
