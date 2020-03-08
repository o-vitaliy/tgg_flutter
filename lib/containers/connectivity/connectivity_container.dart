import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/connectivity/connectivity_actions.dart';
import 'package:tgg/redux_model/app_state.dart';

WidgetBuilder _defaultOfflineLabel = (BuildContext context) => Container(
      width: double.infinity,
      color: Colors.red,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            "Offline",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );

class ConnectivityContainer extends StatelessWidget {
  final WidgetBuilder offlineWidgetBuilder;

  ConnectivityContainer({Key key, WidgetBuilder builder})
      : this.offlineWidgetBuilder = builder ?? _defaultOfflineLabel,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        onInit: (store) => store.dispatch(ConnectivityStartListenAction()),
        onDispose: (store) => store.dispatch(ConnectivityStopListenAction()),
        builder: (BuildContext context, _ViewModel vm) {
          return vm.connected
              ? SizedBox.shrink()
              : offlineWidgetBuilder(context);
        });
  }
}

@immutable
class _ViewModel {
  final bool connected;

  _ViewModel({this.connected});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(connected: store.state.connectivity.connected);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          connected == other.connected;

  @override
  int get hashCode => connected.hashCode;
}
