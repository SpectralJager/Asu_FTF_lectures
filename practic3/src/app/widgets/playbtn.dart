part of 'widgets.dart';

class PlayBtn extends StatelessWidget {
  const PlayBtn({
    Key? key,
    required this.on_tap,
  }) : super(key: key);

  final void Function() on_tap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      right: 0,
      child: GestureDetector(
        onTap: on_tap,
        child: Stack(
          children: [
            SvgPicture.asset(
              "assets/svg/btn.svg",
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            Positioned(
              child: Icon(
                Icons.play_arrow,
                size: 40,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              bottom: 4,
              right: 4,
            ),
          ],
        ),
      ),
    );
  }
}
