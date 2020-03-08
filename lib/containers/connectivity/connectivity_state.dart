import 'package:meta/meta.dart';
import 'package:moor/moor.dart';

@immutable
class ConnectivityState {
  final bool connected;
  final int subscribersCount;

  ConnectivityState(
      {@required this.connected, @required this.subscribersCount});

  ConnectivityState copyWith({Value<bool> connected, int subscribersCount}) {
    return ConnectivityState(
        connected: connected != null ? connected.value : this.connected,
        subscribersCount: subscribersCount ?? this.subscribersCount);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectivityState &&
          runtimeType == other.runtimeType &&
          connected == other.connected;

  @override
  int get hashCode => connected.hashCode;

  factory ConnectivityState.initial() =>
      ConnectivityState(connected: true, subscribersCount: 0);
}
