import 'package:flutter/cupertino.dart';
import 'package:tgg/models/models.dart';
import 'package:tgg/models/routing.dart';

/*
class LogIn {
  final String gameCode;

  LogIn(this.gameCode);
}
*/

class ReLogIn {}

class LogInSuccessful {
  final LoginResponse loginResponse;
  final Playthrough playthrough;
  final Routing routing;

  LogInSuccessful({@required this.loginResponse, @required this.playthrough, @required this.routing});
}

class LogInFails {
  final dynamic error;

  LogInFails(this.error);

  @override
  String toString() {
    return 'LogInFails{error: $error}';
  }
}

class LogOut {}
