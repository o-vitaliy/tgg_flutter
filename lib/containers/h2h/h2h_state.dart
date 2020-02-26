import 'package:meta/meta.dart';

@immutable
class H2HState {
  final int challengesLeft;
  final String opponentId;
  final String opponentName;

  H2HState._({
    this.challengesLeft,
    this.opponentId,
    this.opponentName,
  });

  H2HState copy({
    int challengesLeft,
    String opponentId,
    String opponentName,
    bool inPlay,
  }) {
    return H2HState._(
      challengesLeft: challengesLeft ?? this.challengesLeft,
      opponentId: opponentId ?? this.opponentId,
      opponentName: opponentName ?? this.opponentName,
    );
  }

  factory H2HState.initial() => H2HState._();
}
