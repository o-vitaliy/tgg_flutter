import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/mission/bonus/bonus_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_container.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';

class BonusContainer extends StatelessWidget {
  BonusContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.isLoading)
            return LoadingIndicator();
          else if (vm.waypointId != null)
            return WaypointContainer(vm.waypointId);
          else
            return Text("Upsss... Here is no  bonus camera");
        });
  }
}

class _ViewModel {
  final bool isLoading;
  final String waypointId;

  _ViewModel({
    this.isLoading,
    this.waypointId,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final BonusState state = store.state.bonus;
    return _ViewModel(
      isLoading: state.isLoading,
      waypointId:
          store.state.waypointsPassingState.getWaypointForType(Mode.camera)?.id,
    );
  }
}
