part of 'gameselect.dart';

abstract class GameSelectState extends Equatable {
  final OfflineType type;

  GameSelectState(this.type);

  @override
  List<Object> get props => [type];
}

class GameSelectInit extends GameSelectState {
  GameSelectInit() : super(OfflineType.Timer);
}

class GameSelectCurrent extends GameSelectState {
  GameSelectCurrent(OfflineType type) : super(type);
}
