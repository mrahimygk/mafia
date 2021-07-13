part of 'player_list_cubit.dart';

abstract class PlayerListState extends WidgetState {
  const PlayerListState();
}

class PlayerListInitialState extends PlayerListState {
  @override
  List<Object?> get props => [];
}

class PlayerListLoadingState extends PlayerListState {
  @override
  List<Object?> get props => [];
}

class PlayerListNoDataState extends PlayerListState {
  @override
  List<Object?> get props => [];
}

class PlayerListErrorState extends PlayerListState {
  final String error;

  PlayerListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class PlayerListDataReceivedState extends PlayerListState {
  final List<Player> players;

  PlayerListDataReceivedState(this.players);

  @override
  List<Object?> get props => [players];
}

class PlayerListDataRemovedState extends PlayerListState {
  final List<Player> players;

  PlayerListDataRemovedState(this.players);

  @override
  List<Object?> get props => [players];
}

class PlayerListDataFilledState extends PlayerListState {
  final List<Player> players;

  PlayerListDataFilledState(this.players);

  @override
  List<Object?> get props => [players];
}

class PlayerListNavigationState extends PlayerListState implements NavigationState {
  @override
  final String destination;
  @override
  final dynamic args;

  @override
  String? popUntil;

  @override
  NavigationType? navigationType;

  PlayerListNavigationState(this.destination, this.args);

  @override
  List<Object> get props => [args, destination];
}