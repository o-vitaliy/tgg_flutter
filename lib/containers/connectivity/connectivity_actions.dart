import 'package:meta/meta.dart';

@immutable
class ConnectivityStateChangedAction {
  final bool connected;

  ConnectivityStateChangedAction(this.connected);
}

class ConnectivityStartListenAction {}

class ConnectivityStopListenAction {}

@immutable
class ConnectivityChangeSubscriberAction {
  final int change;

  ConnectivityChangeSubscriberAction(this.change);
}
