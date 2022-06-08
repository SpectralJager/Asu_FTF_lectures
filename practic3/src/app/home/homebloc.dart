part of 'home.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeInit()) {
    on<HomeChangeView>(_changeView);
  }

  void _changeView(HomeChangeView event, Emitter<HomeState> emit) {
    final view_id = event.view_id;
    if (view_id >= 0) {
      emit(HomeCurrentView(view_id));
    }
  }
}
