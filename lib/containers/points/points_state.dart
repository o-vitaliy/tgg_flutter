import 'package:meta/meta.dart';

@immutable
class PointsState {
  final double value;

  PointsState({@required this.value});

  PointsState copyWith({double value}) {
    return PointsState(value: value ?? this.value);
  }

  factory PointsState.initial() {
    return PointsState(value: 0);
  }
}
