import 'models.dart';

class LoginResponse {
  Team team;
  String token;

  LoginResponse.fromJsonMap(Map<String, dynamic> map) {
    team = Team.fromJsonMap(map["team"]);
    token = map["token"];
  }
}
