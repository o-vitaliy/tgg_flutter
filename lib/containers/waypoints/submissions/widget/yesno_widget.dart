import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/containers/h2h/h2h_widget_helper.dart';
import 'package:tgg/containers/team/team_actions.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/containers/waypoints/waypoints_actions.dart';
import 'package:tgg/models/waypoints/submission_choice.dart';
import 'package:tgg/redux_model/app_state.dart';

class YesnoWidget extends StatelessValueWidget {
  final List<SubmissionChoice> choices;

  YesnoWidget(OnValueChange onValueChange, OnSubmit onSubmit,
      dynamic initialValue, this.choices,
      {Key key})
      : super(onValueChange, onSubmit, initialValue, key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        builder: (BuildContext context, _ViewModel vm) {
          return initialValue == null
              ? buildAnswersWidget(vm)
              : buildTeamWidget(
                  flavor: vm.flavor,
                  text: "mission:linked:wait",
                  buttonTitle: "mission:wait_refresh",
                  click: vm.refresh,
                );
        });
  }

  Widget buildAnswersWidget(_ViewModel vm) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: List<Widget>.of(choices.map((choice) {
          return RaisedButton(
            child: Text(choice.text),
            onPressed: () => onValueChange(choice.value),
            key: ValueKey(choice.text),
          );
        }))
          ..add(Text(
            vm.flavor.get("mission:footnotes:linked_head_to_head"),
          )));
  }
}

class _ViewModel {
  final Flavor flavor;
  final Function refresh;

  _ViewModel({this.flavor, this.refresh});

  static _ViewModel fromStore(Store<AppState> store) {
    final flavor = store.state.flavor;

    final Function refresh = () {
      store.dispatch(WaypointsStartLoadAction());
      store.dispatch(TeamStartUpdatingAction());
    };

    return _ViewModel(flavor: flavor, refresh: refresh);
  }
}
