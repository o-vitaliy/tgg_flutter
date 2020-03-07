import 'package:meta/meta.dart';
import 'package:moor/moor.dart';
import 'package:tgg/models/mission.dart';

@immutable
class AnytimeState {
  final bool listLoading;
  final bool waypointLoading;
  final List<Mission> missionPreviewList;
  final List<Mission> missionList;

  bool get isLoading => listLoading || waypointLoading;

  AnytimeState._({
    this.listLoading,
    this.waypointLoading,
    this.missionPreviewList,
    this.missionList,
  });

  factory AnytimeState.initial() => AnytimeState._(
      listLoading: true, waypointLoading: false, missionPreviewList: []);

  AnytimeState copy({
    Value<bool> listLoading,
    Value<bool> waypointLoading,
    List<Mission> missionPreviewList,
    List<Mission> missionList,
  }) {
    return AnytimeState._(
      listLoading: listLoading != null ? listLoading.value : this.listLoading,
      waypointLoading: waypointLoading != null
          ? waypointLoading.value
          : this.waypointLoading,
      missionList: missionList ?? this.missionList,
      missionPreviewList: missionPreviewList ?? this.missionPreviewList,
    );
  }
}
