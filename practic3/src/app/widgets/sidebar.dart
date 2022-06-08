part of 'widgets.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int current_page =
        context.select((HomeBloc bloc) => bloc.state.current_view);
    return Container(
      padding: EdgeInsets.only(top: 80),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * .15,
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          SideBarItem(
            icon: Icons.home,
            iconColor: current_page == 0
                ? Colors.white
                : Theme.of(context).colorScheme.onSecondary,
            index: 0,
          ),
          SideBarItem(
            icon: Icons.leaderboard,
            iconColor: current_page == 1
                ? Colors.white
                : Theme.of(context).colorScheme.onSecondary,
            index: 1,
          ),
          SideBarItem(
            icon: Icons.library_books,
            iconColor: current_page == 2
                ? Colors.white
                : Theme.of(context).colorScheme.onSecondary,
            index: 2,
          ),
          Expanded(
              child: SizedBox(
            width: 1,
          )),
          SideBarItem(
            icon: Icons.people,
            iconColor: current_page == 3
                ? Colors.white
                : Theme.of(context).colorScheme.onSecondary,
            index: 3,
          ),
        ],
      ),
    );
  }
}

class SideBarItem extends StatelessWidget {
  const SideBarItem({
    Key? key,
    required this.index,
    required this.iconColor,
    required this.icon,
  }) : super(key: key);

  final int index;
  final Color iconColor;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: IconButton(
        onPressed: () {
          context.read<HomeBloc>().add(HomeChangeView(view_id: index));
        },
        icon: Icon(
          icon,
          color: iconColor,
        ),
      ),
    );
  }
}
