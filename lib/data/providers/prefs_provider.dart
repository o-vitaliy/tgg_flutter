import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsProvider {
  static const onbprding = "onbording";
  static const logged_in = "logged_in";
  static const game_code = "game_code";

  Future<bool> isOnbordingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onbprding) ?? false;
  }

  Future setOnbordingSeen({bool seen = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(onbprding, seen);
  }

  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(logged_in) ?? false;
  }

  Future setLoggedIn({bool seen = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(logged_in, seen);
  }

  Future clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(onbprding);
  }

  Future setGameCode(String code) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(game_code, code);
  }

  Future<String> getGameCode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(game_code);
  }
}

final prefsProvider = PrefsProvider();
