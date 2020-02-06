import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor_actions.dart';

import 'flavor.dart';

final flavorReducer = combineReducers<Flavor>([
  new TypedReducer<Flavor, UpdateFlavorAction>(_updateFlavor),
]);

Flavor _updateFlavor(Flavor response, action) {
  return Flavor((action as UpdateFlavorAction).flavor);
}
