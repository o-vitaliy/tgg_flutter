import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tgg/models/models.dart';

abstract class GameEvent extends Equatable {
  GameEvent([List props = const []]) : super(props);
}

class GameLoadedEvent extends GameEvent {
  final Game game;

  GameLoadedEvent({@required this.game}) : super([game]);

  @override
  String toString() => 'GameLoadedEvent { game: $game }';
}
