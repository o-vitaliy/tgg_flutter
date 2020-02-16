import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/containers/waypoints/submissions/submission_types.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_state.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/redux_model/app_state.dart';

import '../submissions/widget/submissions_builder.dart';

typedef WidgetsBuilder = Iterable<Widget> Function(BuildContext context);

class WaypointContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        onInit: (store) {
          final waypointId = store.state.waypointState.waypoint.id;
          store.dispatch(WaypointStarted(waypointId));
        },
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return Column(
              children: [
            Text(vm.title),
            MarkdownBody(data: vm.text),
          ]
                ..addAll(vm.builder(context))
                ..add(getHintView(vm))
                ..add(getHintButton(vm))
                ..add(RaisedButton(
                  child: Text(vm.flavor.get("mission:submit")),
                  onPressed:
                      vm.isSubmitEnabled ? () => vm.onSubmit(context) : null,
                )));
        });
  }

  Widget getHintView(_ViewModel vm) {
    if (vm.hint == null || vm.hint.isEmpty) return SizedBox.shrink();
    return Text(vm.hint);
  }

  Widget getHintButton(_ViewModel vm) {
    if (vm.hintRemained == null || vm.hintRemained == 0)
      return SizedBox.shrink();
    final text = vm.flavor.get("mission:hints:get", params: {
      "numRemaining": vm.hintRemained,
      "hintPointCost": vm.hintPrice
    });
    return RaisedButton(
      child: Text(text),
      onPressed: vm.onHint,
    );
  }
}

class _ViewModel {
  final String title;
  final String text;
  final WidgetsBuilder builder;
  final Flavor flavor;
  final OnSubmit onSubmit;
  final String hint;
  final int hintPrice;
  final int hintRemained;
  final OnHint onHint;
  final bool isSubmitEnabled;

  _ViewModel({
    @required this.title,
    @required this.text,
    @required this.builder,
    @required this.flavor,
    @required this.onSubmit,
    @required this.hint,
    @required this.hintPrice,
    @required this.hintRemained,
    @required this.onHint,
    @required this.isSubmitEnabled,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    final WaypointState state = store.state.waypointState;
    final Waypoint waypoint = state.waypoint;

    final items = state.items;

    final OnSubmit onSubmit =
        (context) => store.dispatch(WaypointSubmit(context));
    final OnHint onHint = () => store.dispatch(WaypointShowHintAction());

    final WidgetsBuilder builder = (BuildContext context) {
      return items.map((item) {
        final type = SubmissionTypeHelper.fromString(item.submission.type);
        final answer = item.answer;
        final OnValueChange onChange = (value) {
          store.dispatch(WaypointUpdateAnswer(value, item.submission));
        };
        return build(
          type,
          onChange,
          onSubmit,
          value: answer,
          variants: item.submission.choices,
        );
      });
    };
    return _ViewModel(
        title: waypoint.step.title,
        text: waypoint.step.instructions,
        builder: builder,
        flavor: store.state.flavor,
        onSubmit: onSubmit,
        hint: state.hint,
        hintPrice: state.hintPrice,
        hintRemained: state.hintRemained,
        onHint: onHint,
        isSubmitEnabled: state.isEnabled);
  }
}
