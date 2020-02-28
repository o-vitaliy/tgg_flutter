import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/mission/anytime/anytime_list.dart';
import 'package:tgg/containers/mission/anytime/anytime_state.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_container.dart';
import 'package:tgg/models/mission.dart';
import 'package:tgg/models/waypoints/waypoint_mode.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/widgets/base_square_icon_button.dart';
import 'package:tgg/ui/widgets/loading_indicator.dart';

import 'anytime_action.dart';

class AnytimeListContainer extends StatelessWidget {
  AnytimeListContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        builder: (BuildContext context, _ViewModel vm) {
          if (vm.isLoading)
            return LoadingIndicator();
          else if (vm.waypointId != null)
            return waipointContainer(vm);
          else
            return AnytimeList(
              missions: vm.missions,
              onSelect: vm.onSelect,
            );
        });
  }

  Widget waipointContainer(_ViewModel vm) {
    if (vm.missions.length == 1) {
      return WaypointContainer(vm.waypointId);
    } else {
      return Stack(
        children: <Widget>[
          WaypointContainer(vm.waypointId),
          BaseSquareIconButton(
            icon: FontAwesomeIcons.arrowLeft,
            color: Colors.deepOrange,
            dimension: 32,
            onTap: (_) => vm.onRemoveWaypoint(vm.waypointId),
          ),
        ],
      );
    }
  }
}

class _ViewModel {
  final bool isLoading;
  final List<Mission> missions;
  final String waypointId;
  final Function(Mission) onSelect;
  final Function(String) onRemoveWaypoint;

  _ViewModel(
      {this.isLoading,
      this.missions,
      this.waypointId,
      this.onSelect,
      this.onRemoveWaypoint});

  static _ViewModel fromStore(Store<AppState> store) {
    final AnytimeState state = store.state.anytime;
    final Function(Mission) onSelect =
        (m) => store.dispatch(AnytimeLoadWaypointAction(m.id));
    final Function(String) onRemoveWaypoint =
        (waypointId) => store.dispatch(WaypointRemoveAction(waypointId));
    return _ViewModel(
      isLoading: state.isLoading,
      missions: state.missions,
      waypointId: store.state.waypointsPassingState
          .getWaypointForType(Mode.anytime)
          ?.id,
      onSelect: onSelect,
      onRemoveWaypoint: onRemoveWaypoint,
    );
  }
}
