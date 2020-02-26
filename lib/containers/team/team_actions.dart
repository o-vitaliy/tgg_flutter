import 'package:meta/meta.dart';
import 'package:tgg/models/team.dart';

@immutable
class TeamStartUpdatingAction {}

@immutable
class TeamStartUpdateAction {
  final Team team;

  TeamStartUpdateAction(this.team);
}
