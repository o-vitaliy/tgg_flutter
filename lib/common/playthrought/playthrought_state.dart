import 'package:meta/meta.dart';
import 'package:tgg/models/playthrough.dart';

@immutable
class PlaythroughtState {
  final Playthrough playthrough;

  PlaythroughtState({
    @required this.playthrough,
  });

  PlaythroughtState copyWith({
    Playthrough playthrough,
  }) =>
      PlaythroughtState(
        playthrough: playthrough ?? this.playthrough,
      );

  factory PlaythroughtState.initial() {
    return PlaythroughtState(playthrough: null);
  }
}
