import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/containers/waypoints/submissions/widget/value_widget.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_actions.dart';
import 'package:tgg/containers/waypoints/waypoint/waypoint_item_state.dart';
import 'package:tgg/models/waypoints/waypoint.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/common/theme/theme_config.dart';
import 'package:tgg/common/theme/themed_buttons.dart';

import '../submissions/widget/submissions_builder.dart';

typedef WidgetsBuilder = Iterable<Widget> Function(BuildContext context);

class WaypointContainer extends StatelessWidget {
  final String waypointId;

  const WaypointContainer(
    this.waypointId, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store, waypointId),
        onInit: (store) {
          store.dispatch(WaypointStarted(waypointId));
        },
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          final List<Widget> list = [
            Text(
              vm.title,
              textAlign: TextAlign.center,
              style: headerTextStyle,
            ),
            MarkdownBody(data: vm.text),
          ]
            ..addAll(vm.builder(context))
            ..add(getHintView(vm))
            ..add(getHintButton(vm))
            ..add(vm.isSubmitVisible
                ? getMainTextButton(
                    label: vm.flavor.get("mission:submit"),
                    onPressed: vm.isSubmitEnabled ? () => vm.onSubmit() : null,
                  )
                : SizedBox.shrink());
          final items = list
              .map((item) =>
                  Padding(padding: EdgeInsets.only(top: 8), child: item))
              .toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: items,
          );
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
    return getMainTextButton(
      label: text,
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
  final bool isSubmitVisible;
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
    @required this.isSubmitVisible,
    @required this.isSubmitEnabled,
  });

  static _ViewModel fromStore(Store<AppState> store, String waypointId) {
    final WaypointItemState state =
        store.state.waypointsPassingState[waypointId];
    final Waypoint waypoint = state.waypoint;

    final items = state.items;

    final OnSubmit onSubmit = () => store.dispatch(WaypointSubmit(waypointId));
    final OnHint onHint =
        () => store.dispatch(WaypointShowHintAction(waypointId));

    final WidgetsBuilder builder = (BuildContext context) {
      return items.map((item) {
        final OnValueChange onChange = (value) {
          store.dispatch(WaypointUpdateAnswer(
              waypointId, item.id, value, item.submission));
        };
        return build(
          item,
          onChange,
          onSubmit,
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
        isSubmitVisible: state.isVisible,
        isSubmitEnabled: state.isEnabled);
  }
}
