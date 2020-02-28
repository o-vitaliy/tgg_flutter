import 'package:flutter/cupertino.dart';
import 'package:tgg/models/models.dart';
import 'package:tgg/models/routing.dart';

class ReLogIn {}

class LogInSuccessful {
  final LoginResponse loginResponse;
  final Playthrough playthrough;

  LogInSuccessful({@required this.loginResponse, @required this.playthrough});
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
