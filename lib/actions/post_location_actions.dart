import 'dart:async';

class StartPostingLocation {}

class PostingLocationStarted {
  final Timer timer;

  PostingLocationStarted(this.timer);
}

class StopPostingLocation {
  final Timer timer;

  StopPostingLocation(this.timer);
}

class PostingLocationStopped {}

class PostLocation {}
