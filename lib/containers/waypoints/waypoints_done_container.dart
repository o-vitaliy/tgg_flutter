import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/redux_model/app_state.dart';

class WaypointsDoneContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
         return Text(vm.flavor.get("persistent:nomissions"));
        });
  }
}

class _ViewModel {
  final Flavor flavor;

  _ViewModel({this.flavor});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      flavor: store.state.flavor
    );
  }
}
