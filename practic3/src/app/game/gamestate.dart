part of 'game.dart';

abstract class GameState extends Equatable {
  final Game game;

  GameState(this.game);

  @override
  List<Object> get props => [game];
}

class GameStateInit extends GameState {
  GameStateInit(Game? game) : super(game ?? Game());
}

class GameStateRunning extends GameState {
  GameStateRunning(Game game) : super(game);
}

class GameStateFinish extends GameState {
  GameStateFinish(Game game) : super(game);
}
