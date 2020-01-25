import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
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
          ]..addAll(vm.builder(context)));
        });
  }
}

class _ViewModel {
  final String title;
  final String text;
  final WidgetsBuilder builder;

  _ViewModel({this.title, this.text, this.builder});

  static _ViewModel fromStore(Store<AppState> store) {
    final WaypointState state = store.state.waypointState;
    final Waypoint waypoint = state.waypoint;
    final items = state.items;

    final OnSubmit onSubmit = () => store.dispatch(WaypointSubmit());

    final WidgetsBuilder builder = (BuildContext context) {
      return items.map((item) {
        final type = SubmissionTypeHelper.fromString(item.submission.type);
        final error = item.error;
        final answer = item.answer;
        final OnValueChange onChange = (value) {
          store.dispatch(WaypointUpdateAnswer(value, item.submission));
        };
        return build(type, answer, error, onChange, onSubmit);
      });
    };
    return _ViewModel(
      title: waypoint.step.title,
      text: waypoint.step.instructions,
      builder: builder,
    );
  }
}
