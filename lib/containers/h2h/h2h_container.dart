import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/h2h/invite/h2h_invite_container.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_container.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';

class H2HContainer extends StatelessWidget {
  H2HContainer({Key key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.waypointId == null) {
            return H2HInviteContainer();
          } else {
            return WaypointContainer(vm.waypointId);
          }
        });
  }
}

class _ViewModel {
  final String waypointId;

  _ViewModel({this.waypointId});

  static _ViewModel fromStore(final Store<AppState> store) {
    final AppState state = store.state;
    return _ViewModel(
      waypointId: state.waypointsPassingState.getWaypointForType(H2HMode())?.id,
    );
  }
}
