enum PlaythroughStatus {
  closed,
  started,
  paused,
  ending,
  ended,
  voting,
  archived
}

class PlaythroughStatusHelper {
  static PlaythroughStatus getFromInt(int value) {
    switch (value) {
      case 100:
        return PlaythroughStatus.closed;
      case 300:
        return PlaythroughStatus.started;
      case 400:
        return PlaythroughStatus.paused;
      case 500:
        return PlaythroughStatus.ending;
      case 600:
        return PlaythroughStatus.ended;
      case 700:
        return PlaythroughStatus.voting;
      case 800:
        return PlaythroughStatus.archived;
    }

    throw ArgumentError("PlaythroughStatus unsupported value $value");
  }
}
