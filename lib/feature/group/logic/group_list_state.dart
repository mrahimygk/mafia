part of 'group_list_cubit.dart';

abstract class GroupListState extends WidgetState {
  const GroupListState();
}

class GroupListInitialState extends GroupListState {
  @override
  List<Object?> get props => [];
}

class GroupListLoadingState extends GroupListState {
  @override
  List<Object?> get props => [];
}

class GroupListNoDataState extends GroupListState {
  @override
  List<Object?> get props => [];
}

class GroupListErrorState extends GroupListState {
  final String error;

  GroupListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class GroupListDataReceivedState extends GroupListState {
  final List<Group> groups;

  GroupListDataReceivedState(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupListDataFilledState extends GroupListState {
  final List<Group> groups;

  GroupListDataFilledState(this.groups);

  @override
  List<Object?> get props => [groups];
}

class GroupListNavigationState extends GroupListState
    implements NavigationState {
  @override
  final String destination;
  @override
  final dynamic args;

  @override
  String? popUntil;

  @override
  NavigationType? navigationType;

  GroupListNavigationState(this.destination, this.args);

  @override
  List<Object> get props => [args, destination];
}
