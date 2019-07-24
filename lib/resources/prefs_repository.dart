import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {
  static const onbprding = "onbording";

  Future<bool> isOnbordingSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(onbprding) ?? false;
  }

  Future setOnbordingSeen({bool seen = true}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(onbprding, seen);
    print("PrefsRepository save");
  }

  Future clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(onbprding);
  }
}
