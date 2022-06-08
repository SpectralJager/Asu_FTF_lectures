part of 'home.dart';

abstract class HomeState extends Equatable {
  final int current_view;

  const HomeState(this.current_view);

  @override
  List<Object> get props => [this.current_view];
}

class HomeInit extends HomeState {
  const HomeInit() : super(0);
}

class HomeCurrentView extends HomeState {
  const HomeCurrentView(int view_id) : super(view_id);
}
