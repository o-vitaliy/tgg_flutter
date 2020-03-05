import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/common/flavor/flavor.dart';
import 'package:tgg/common/theme/theme_config.dart';
import 'package:tgg/redux_model/app_state.dart';

class PointsContainer extends StatelessWidget {
  const PointsContainer();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const _Line(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                child: Text(
                  vm.pointLabel,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const _Line(),
            ],
          );
        });
  }
}

@immutable
class _ViewModel {
  final String pointLabel;

  _ViewModel({this.pointLabel});

  static _ViewModel fromStore(Store<AppState> store) {
    final Flavor flavor = store.state.flavor;
    final points = store.state.points.value.toInt();
    final String pointLabel = "$points ${flavor.get("global:points")}";
    return _ViewModel(pointLabel: pointLabel);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          pointLabel == other.pointLabel;

  @override
  int get hashCode => pointLabel.hashCode;
}

class _Line extends StatelessWidget {
  const _Line();

  @override
  Widget build(BuildContext context) =>
      Expanded(child: Container(color: themeConfig.fontColor, height: 1));
}
