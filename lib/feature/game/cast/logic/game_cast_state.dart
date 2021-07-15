part of 'game_cast_cubit.dart';

abstract class GameCastState extends WidgetState {
  const GameCastState();
}

class GameCastInitialState extends GameCastState {
  @override
  List<Object?> get props => [];
}

class GameCastLoadingState extends GameCastState {
  @override
  List<Object?> get props => [];
}

class GameCastNoDataState extends GameCastState {
  @override
  List<Object?> get props => [];
}

class GameCastErrorState extends GameCastState {
  final String error;

  GameCastErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class GameCastDataReceivedState extends GameCastState {
  final Game game;

  GameCastDataReceivedState(this.game);

  @override
  List<Object?> get props => [game];
}
