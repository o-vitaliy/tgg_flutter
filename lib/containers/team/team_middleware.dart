import 'package:redux/redux.dart';
import 'package:tgg/containers/team/team_actions.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';

List<Middleware<AppState>> createTeamMiddleware() {
  return [
    new TypedMiddleware<AppState, TeamStartUpdatingAction>(_loadTeam()),
  ];
}

Middleware<AppState> _loadTeam() {
  return (Store store, action, NextDispatcher next) async {
    if (action is TeamStartUpdatingAction) {
      final teamId = store.state.team.id;
      teamRepo.updateTeam(teamId).then((team) {
        store.dispatch(TeamStartUpdateAction(team));
      });
    }
    next(action);
  };
}
