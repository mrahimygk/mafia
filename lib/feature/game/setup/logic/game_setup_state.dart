part of 'game_setup_cubit.dart';

abstract class GameSetupState extends WidgetState {
  const GameSetupState();
}

class GameSetupInitialState extends GameSetupState {
  @override
  List<Object?> get props => [];
}

class GameSetupLoadingState extends GameSetupState {
  @override
  List<Object?> get props => [];
}

class GameSetupNoDataState extends GameSetupState {
  @override
  List<Object?> get props => [];
}

class GameSetupErrorState extends GameSetupState {
  final String error;

  GameSetupErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class GameSetupDataReceivedState extends GameSetupState {
  @override
  List<Object?> get props => [];
}

class GameSetupDataFilledState extends GameSetupState {

  @override
  List<Object?> get props => [];
}