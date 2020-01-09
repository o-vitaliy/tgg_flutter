import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/waypoints_state.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';

import 'waypoint/waypoint_container.dart';
import 'waypoints_done_container.dart';

class WaypointsContainer extends StatelessWidget {
  WaypointsContainer(Key key) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.isLoading)
            return LoadingIndicator();
          else if (vm.hasMoreGames) {
            return WaypointContainer();
          } else {
            return WaypointsDoneContainer();
          }
        });
  }
}

class _ViewModel {
  final bool isLoading;
  final bool hasMoreGames;

  _ViewModel({this.isLoading, this.hasMoreGames});

  static _ViewModel fromStore(Store<AppState> store) {
    final WaypointsState state = store.state.waypointsState;
    return _ViewModel(
      isLoading: state.isLoading,
      hasMoreGames: store.state.waypointState != null,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          hasMoreGames == other.hasMoreGames;

  @override
  int get hashCode => isLoading.hashCode ^ hasMoreGames.hashCode;
}
