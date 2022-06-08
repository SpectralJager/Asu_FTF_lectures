part of 'home.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final hub_pages = [
    GameSelectView(),
    Center(
      child: Text('leaderboard'),
    ),
    Center(
      child: Text('tutorials'),
    ),
    Center(
      child: Text('Profile'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Row(children: [
            SideBar(),
            SizedBox(
              width: MediaQuery.of(context).size.width * .85,
              height: MediaQuery.of(context).size.height,
              child:
                  BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                return this.hub_pages[state.current_view];
              }),
            ),
          ]),
        ),
      ),
    );
  }
}
