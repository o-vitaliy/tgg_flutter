import 'package:meta/meta.dart';
import 'package:moor/moor.dart';
import 'package:tgg/models/mission.dart';

@immutable
class BonusState {
  final bool listLoading;
  final bool waypointLoading;
  final List<Mission> bonusMissions;

  bool get isLoading => listLoading || waypointLoading;

  BonusState._({
    this.listLoading,
    this.waypointLoading,
    this.bonusMissions,
  });

  factory BonusState.initial() => BonusState._(
        listLoading: true,
        waypointLoading: false,
      );

  BonusState copy({
    Value<bool> listLoading,
    Value<bool> waypointLoading,
    List<Mission> missions,
  }) {
    return BonusState._(
      listLoading: listLoading != null ? listLoading.value : this.listLoading,
      waypointLoading: waypointLoading != null
          ? waypointLoading.value
          : this.waypointLoading,
      bonusMissions: missions ?? this.bonusMissions,
    );
  }
}
