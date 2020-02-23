import 'package:meta/meta.dart';
import 'package:moor/moor.dart';
import 'package:tgg/models/mission.dart';

@immutable
class AnytimeState {
  final bool listLoading;
  final bool waypointLoading;
  final List<Mission> missions;

  bool get isLoading => listLoading || waypointLoading;

  AnytimeState._({
    this.listLoading,
    this.waypointLoading,
    this.missions,
  });

  static AnytimeState initial() => AnytimeState._(
        listLoading: true,
        waypointLoading: false,
      );

  AnytimeState copy({
    Value<bool> listLoading,
    Value<bool> waypointLoading,
    List<Mission> anytimeMission,
  }) {
    return AnytimeState._(
      listLoading: listLoading != null ? listLoading.value : this.listLoading,
      waypointLoading: waypointLoading != null
          ? waypointLoading.value
          : this.waypointLoading,
      missions: anytimeMission ?? this.missions,
    );
  }
}
