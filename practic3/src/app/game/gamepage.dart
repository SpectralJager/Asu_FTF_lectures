part of 'game.dart';

class GamePage extends StatelessWidget {
  const GamePage({Key? key, required this.mode}) : super(key: key);
  final Mode mode;
  @override
  Widget build(BuildContext context) {
    var type = context.read<GameSelectBloc>().state.type;
    return BlocProvider(
      create: (_) => GameBloc(Game(mode: mode)),
      child: GameView(),
    );
  }
}
