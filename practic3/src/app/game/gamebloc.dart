part of 'game.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  late final Game _game;
  GameBloc(Game game) : super(GameStateInit(game)) {
    this._game = game;
    on<GameEventStart>(_onStart);
    on<GameEventSubmit>(_onSubmit);
  }

  void _onSubmit(GameEventSubmit event, Emitter<GameState> emit) {
    var game = state.game;
    if (event.answer == game.result) {
      game = game.incrementPoints();
      if (game.points % (5 * game.lvl) == 0) {
        game = game.changeLvl();
        game = game.changeMinMax();
      }
    } else {
      game = game.decrementPoints();
      game = game.decrementHealth();
    }
    if (game.health == 0) {
      emit(GameStateFinish(game));
    } else {
      game = game.generateValues();
      emit(GameStateRunning(game));
    }
  }

  void _onStart(GameEventStart event, Emitter<GameState> emit) {
    Game game = this._game.copyWith();
    game = game.generateValues();
    emit(GameStateRunning(game));
  }
}
