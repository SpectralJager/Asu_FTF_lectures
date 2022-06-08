part of 'game.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GameEventStart extends GameEvent {}

class GameEventSubmit extends GameEvent {
  final int answer;

  GameEventSubmit(this.answer);
}

class GameEventEnd extends GameEvent {}

class GameEventRestart extends GameEvent {}
