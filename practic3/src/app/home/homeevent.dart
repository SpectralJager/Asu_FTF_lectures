part of 'home.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  List<Object> get props => [];
}

class HomeChangeView extends HomeEvent {
  final int view_id;

  const HomeChangeView({required this.view_id});
}
