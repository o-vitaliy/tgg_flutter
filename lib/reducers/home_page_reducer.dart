import 'package:quiver/core.dart';
import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/actions/home_actions.dart';
import 'package:tgg/models/modes.dart';
import 'package:tgg/redux_model/home_page_state.dart';

final homePageReducer = combineReducers<HomePageState>([
  new TypedReducer<HomePageState, ChangeRouteModeAction>(_changeRouteMode),
  new TypedReducer<HomePageState, LogInSuccessful>(_initRouteModeAction),
]);

HomePageState _changeRouteMode(HomePageState state, action) {
  final RouteMode mode = (action as ChangeRouteModeAction).selectedMode;
  return state.copyWith(
    selectedMode: Optional.fromNullable(mode),
  );
}

HomePageState _initRouteModeAction(HomePageState state, action) {
  return HomePageState.initial(
      (action as LogInSuccessful).playthrough.game.blueprint.routing.modes);
}
