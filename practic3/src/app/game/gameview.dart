part of 'game.dart';

class GameView extends StatelessWidget {
  GameView({Key? key}) : super(key: key);
  final TextEditingController txt_edit_controller =
      TextEditingController(text: '');

  final num_pad = ['7', '8', '9', '4', '5', '6', '1', '2', '3'];
  @override
  Widget build(BuildContext context) {
    var state = context.select((GameBloc bloc) => bloc.state);
    var game = context.select((GameBloc bloc) => bloc.state.game);
    var points = game.points;
    var left_value = game.left_value;
    var right_value = game.right_value;
    var sign;
    switch (game.mode) {
      case Mode.Summation:
        sign = '+';
        break;
      case Mode.Subtraction:
        sign = '-';
        break;
      case Mode.Multiplication:
        sign = '*';
        break;
      case Mode.Division:
        sign = '/';
        break;
    }
    var buttons_text_style = Theme.of(context)
        .textTheme
        .labelLarge!
        .copyWith(color: Theme.of(context).colorScheme.onPrimary);
    return Scaffold(
      body: Column(
        children: [
          if (state is GameStateRunning) ...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 80,
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton.small(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.clear),
                  ),
                  Container(
                    child: Text(
                      "$points p",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 30,
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < game.health; i++)
                    Icon(
                      Icons.heart_broken,
                      size: 28,
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                ],
              ),
            ),
            Text(
              "$left_value $sign $right_value",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            Container(
              height: 120,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(
                horizontal: 80,
              ),
              margin: EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: this.txt_edit_controller,
                enabled: false,
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                decoration: InputDecoration(
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Answer: ',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context).colorScheme.onBackground,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.9,
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
              ),
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                children: [
                  for (var i in this.num_pad)
                    NumPadBtn(
                      txt_edit_controller: txt_edit_controller,
                      buttons_text_style: buttons_text_style,
                      text: i,
                    ),
                  ElevatedButton(
                      onPressed: () {
                        this.txt_edit_controller.clear();
                      },
                      child: Icon(
                        Icons.clear,
                        color: Theme.of(context).colorScheme.onPrimary,
                      )),
                  ElevatedButton(
                      onPressed: () {
                        this.txt_edit_controller.text += '0';
                      },
                      child: Text(
                        '0',
                        style: buttons_text_style,
                      )),
                  ElevatedButton(
                    onPressed: () {
                      if (this.txt_edit_controller.text != '') {
                        context.read<GameBloc>().add(GameEventSubmit(
                            int.parse(this.txt_edit_controller.text)));
                        this.txt_edit_controller.clear();
                      }
                    },
                    child: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (state is GameStateFinish) ...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your points ${game.points}',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      context.read<GameBloc>().add(GameEventStart());
                    },
                    elevation: 0,
                    label: Text('Try again'),
                    icon: Icon(Icons.play_arrow),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text('back'),
                    icon: Icon(Icons.arrow_back),
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            )
          ],
          if (state is GameStateInit) ...[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      context.read<GameBloc>().add(GameEventStart());
                    },
                    elevation: 0,
                    label: Text('Start'),
                    icon: Icon(Icons.play_arrow),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    label: Text('back'),
                    icon: Icon(Icons.arrow_back),
                    elevation: 0,
                    backgroundColor: Theme.of(context).colorScheme.background,
                    foregroundColor: Theme.of(context).colorScheme.onBackground,
                  ),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }
}

class NumPadBtn extends StatelessWidget {
  const NumPadBtn({
    Key? key,
    required this.txt_edit_controller,
    required this.buttons_text_style,
    required this.text,
  }) : super(key: key);

  final TextEditingController txt_edit_controller;
  final TextStyle buttons_text_style;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          this.txt_edit_controller.text += text;
        },
        child: Text(
          text,
          style: buttons_text_style,
        ));
  }
}
