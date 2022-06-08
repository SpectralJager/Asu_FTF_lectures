part of 'gameselect.dart';

class GameSelectBloc extends Cubit<GameSelectState> {
  GameSelectBloc() : super(GameSelectInit()) {}

  void changeType(int index) {
    var type = OfflineType.values[index];
    if (type.name != state.type.name) {
      emit(GameSelectCurrent(type));
    }
  }
}
