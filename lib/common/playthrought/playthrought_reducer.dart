import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';

import 'playthrought_state.dart';

final playthoughReducer = combineReducers<PlaythroughtState>([
  new TypedReducer<PlaythroughtState, LogInSuccessful>(_logIn),
  new TypedReducer<PlaythroughtState, LogOut>(_logOut),
]);

PlaythroughtState _logIn(PlaythroughtState response, action) {
  return response.copyWith(
      playthrough: (action as LogInSuccessful).playthrough);
}

PlaythroughtState _logOut(PlaythroughtState response, action) {
  return PlaythroughtState.initial();
}
