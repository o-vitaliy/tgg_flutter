import 'package:redux/redux.dart';
import 'package:tgg/actions/auth_actions.dart';
import 'package:tgg/common/theme/theme_config.dart';
import 'package:tgg/data/providers.dart';
import 'package:tgg/redux_model/app_state.dart';

import 'flavor_actions.dart';

const _defaultBlueprint = "gogame";

List<Middleware<AppState>> createFlavorMiddleware() {
  return [
    new TypedMiddleware<AppState, FlavorLoadDefaultAction>(_loadDefault()),
    new TypedMiddleware<AppState, FlavorLoadAction>(_load()),
    new TypedMiddleware<AppState, LogOut>(_loadDefault()),
  ];
}

Middleware<AppState> _loadDefault() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FlavorLoadDefaultAction || action is LogOut) {
      final flavor = await staticRepo.getFlavor(_defaultBlueprint);
      store.dispatch(FlavorSaveAction(flavor));
      themeConfig.flavor = store.state.flavor;
    }
    next(action);
  };
}

Middleware<AppState> _load() {
  return (Store<AppState> store, action, NextDispatcher next) async {
    if (action is FlavorLoadAction) {
      final flavor =
          await staticRepo.getGameFlavor(action.blueprintId, action.gameId);
      store.dispatch(FlavorSaveAction(flavor));
      themeConfig.flavor = store.state.flavor;
    }
    next(action);
  };
}
