enum ChallengeState {
  inProgress,
  sent,
  received,
  didDecline,
  wasDecline,
  exhausted
}

class ChallengeStateHelper {
  static ChallengeState fromString(String value) {
    switch (value) {
      case "in_progress":
        return ChallengeState.inProgress;
      case "sent":
        return ChallengeState.sent;
      case "received":
        return ChallengeState.received;
      case "did_decline":
        return ChallengeState.didDecline;
      case "was_decline":
        return ChallengeState.wasDecline;
      case "exhausted":
        return ChallengeState.exhausted;
      default:
        return null;
    }
  }
}
