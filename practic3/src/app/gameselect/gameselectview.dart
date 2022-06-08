part of 'gameselect.dart';

class GameSelectView extends StatefulWidget {
  const GameSelectView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _GameSelectViewState();
}

class _GameSelectViewState extends State<GameSelectView>
    with SingleTickerProviderStateMixin {
  late TabController _tab_controller;
  final animations_list = [
    "assets/anim/plus.json",
    "assets/anim/minus.json",
    "assets/anim/plus.json",
    "assets/anim/div.json",
  ];
  @override
  void initState() {
    super.initState();
    this._tab_controller = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(top: 80, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Offline modes",
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            Container(
              height: 80,
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  controller: this._tab_controller
                    ..addListener(() {
                      context
                          .read<GameSelectBloc>()
                          .changeType(this._tab_controller.index);
                    }),
                  indicator: DotIndicator(
                    color: Theme.of(context).colorScheme.primary,
                    distanceFromCenter: 20,
                    radius: 4,
                  ),
                  tabs: [
                    Tab(
                      text: "Timer",
                    ),
                    Tab(
                      text: "Survive",
                    ),
                    Tab(
                      text: "Endurance",
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width - 20,
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ModeCard(
                    mode: Mode.values[index],
                    mode_anim: this.animations_list[index],
                    lvl: 8,
                    points: 30000,
                  );
                },
                itemCount: Mode.values.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
