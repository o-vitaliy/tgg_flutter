import 'package:redux/redux.dart';
import 'package:tgg/common/blueprint/blueprint_actions.dart';
import 'package:tgg/models/blueprint_model.dart';

final blueprintReducer = combineReducers<BlueprintModel>([
  new TypedReducer<BlueprintModel, UpdateBlueprint>(_updateBlueprint),
]);

BlueprintModel _updateBlueprint(BlueprintModel response, action) {
  return response;
}
