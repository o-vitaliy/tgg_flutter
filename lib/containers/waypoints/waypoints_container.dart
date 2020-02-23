import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/waypoints/waypoints_state.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
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
            return WaypointContainer(vm.waypointId);
          } else {
            return WaypointsDoneContainer();
          }
        });
  }
}

class _ViewModel {
  final bool isLoading;
  final bool hasMoreGames;
  final String waypointId;

  _ViewModel({this.isLoading, this.hasMoreGames, this.waypointId});

  static _ViewModel fromStore(Store<AppState> store) {
    final WaypointsState state = store.state.waypointsState;
    return _ViewModel(
      isLoading: state.isLoading,
      hasMoreGames: store.state.waypointsState.hasGameForMode(Mode.main),
      waypointId: store.state.waypointsPassingState.getWaypointForType(Mode.main)?.id,
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
