part of 'widgets.dart';

class QuestionBtn extends StatelessWidget {
  const QuestionBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 10,
      top: 10,
      child: FloatingActionButton.small(
        heroTag: null,
        child: Text(
          "?",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        onPressed: () {},
      ),
    );
  }
}
