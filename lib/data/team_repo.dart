import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/models.dart';

class TeamRepo {
  final ApiProvider apiProvider;

  TeamRepo({@required this.apiProvider});

  Future<Team> updateTeam(String teamId) async {
    final response = await apiProvider.team(teamId: teamId);
    final map = json.decode(response);
    return Team.fromJsonMap(map);
  }
}
