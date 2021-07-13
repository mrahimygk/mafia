part of 'role_list_cubit.dart';

abstract class RoleListState extends WidgetState {
  const RoleListState();
}

class RoleListInitialState extends RoleListState {
  @override
  List<Object?> get props => [];
}

class RoleListLoadingState extends RoleListState {
  @override
  List<Object?> get props => [];
}

class RoleListNoDataState extends RoleListState {
  @override
  List<Object?> get props => [];
}

class RoleListErrorState extends RoleListState {
  final String error;

  RoleListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class RoleListDataReceivedState extends RoleListState {
  final List<Role> roles;

  RoleListDataReceivedState(this.roles);

  @override
  List<Object?> get props => [roles];
}

class RoleListDataFilledState extends RoleListState {
  final List<Role> roles;

  RoleListDataFilledState(this.roles);

  @override
  List<Object?> get props => [roles];
}

class RoleListNavigationState extends RoleListState implements NavigationState {
  @override
  final String destination;
  @override
  final dynamic args;

  @override
  String? popUntil;

  @override
  NavigationType? navigationType;

  RoleListNavigationState(this.destination, this.args);

  @override
  List<Object> get props => [args, destination];
}