part of 'role_details_cubit.dart';

abstract class RoleDetailsState extends WidgetState {
  const RoleDetailsState();
}

class RoleDetailsInitialState extends RoleDetailsState {
  @override
  List<Object?> get props => [];
}

class RoleDetailsPreloadedState extends RoleDetailsState {
  final Role role;

  RoleDetailsPreloadedState(this.role);

  @override
  List<Object?> get props => [role];
}

class RoleDetailsLoadingState extends RoleDetailsState {
  @override
  List<Object?> get props => [];
}

class RoleDetailsNoDataState extends RoleDetailsState {
  @override
  List<Object?> get props => [];
}

class RoleDetailsErrorState extends RoleDetailsState {
  final String error;

  RoleDetailsErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class RoleDetailsDataReceivedState extends RoleDetailsState {
  final Role role;

  RoleDetailsDataReceivedState(this.role);

  @override
  List<Object?> get props => [role];
}

class RoleDetailsDataFilledState extends RoleDetailsState {
  final Role role;

  RoleDetailsDataFilledState(this.role);

  @override
  List<Object?> get props => [role];
}

class RoleDetailsNavigationState extends RoleDetailsState
    implements NavigationState {
  @override
  final String destination;
  @override
  final dynamic args;

  @override
  String? popUntil;

  @override
  NavigationType? navigationType;

  RoleDetailsNavigationState(this.destination, this.args);

  @override
  List<Object> get props => [args, destination];
}
