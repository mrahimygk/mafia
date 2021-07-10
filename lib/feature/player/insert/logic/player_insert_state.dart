part of 'player_insert_cubit.dart';

abstract class PlayerInsertState extends WidgetState {
  const PlayerInsertState();
}

class PlayerInsertInitialState extends PlayerInsertState {
  @override
  List<Object?> get props => [];
}

class PlayerInsertLoadingState extends PlayerInsertState {
  @override
  List<Object?> get props => [];
}

class PlayerInsertNoDataState extends PlayerInsertState {
  @override
  List<Object?> get props => [];
}

class PlayerInsertErrorState extends PlayerInsertState {
  final String error;

  PlayerInsertErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class PlayerInsertDataReceivedState extends PlayerInsertState {
  final int insertedId;

  PlayerInsertDataReceivedState(this.insertedId);

  @override
  List<Object?> get props => [insertedId];
}

class PlayerInsertDataFilledState extends PlayerInsertState {
  final List<Player> players;

  PlayerInsertDataFilledState(this.players);

  @override
  List<Object?> get props => [players];
}