import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/models.dart';

import 'providers/prefs_provider.dart';

class LoginRepo {
  final ApiProvider apiProvider;
  final PrefsProvider prefs;

  LoginResponse loginResponse;

  LoginRepo({@required this.apiProvider, @required this.prefs});

  Future<LoginResponse> login({@required String code, String pin = ""}) async {
    String response = await apiProvider.login(code);
    final Map<String, dynamic> responseMap = json.decode(response);
    loginResponse = LoginResponse.fromJsonMap(responseMap);
    await prefs.setGameCode(code);
    await prefs.setGamePin(loginResponse.team.pin);
    apiProvider.token = loginResponse.token;
    return loginResponse;
  }

  Future<LoginResponse> reLogin() async {
    final code = await prefs.getGameCode();
    final pin = await prefs.getGamePin();
    if (code != null) {
      try {
        apiProvider.token = null;
        return login(code: code, pin: pin);
      } catch (error) {
        await prefs.setGameCode(null);
        throw error;
      }
    }
    return null;
  }

  Future<LoginResponse> getLoginResponse() async {
    if (loginResponse == null) {
      final gameCode = await prefs.getGameCode();
      if (gameCode != null) {
        await login(code: gameCode);
      }
    }
    return loginResponse;
  }

  Future logout() async {
    loginResponse = null;
    apiProvider.token = null;
    await prefs.setGameCode(null);
  }
}
