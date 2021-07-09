part of 'all_list_cubit.dart';

abstract class AllListState extends WidgetState {
  const AllListState();
}

class AllListInitialState extends AllListState {
  @override
  List<Object?> get props => [];
}

class AllListLoadingState extends AllListState {
  @override
  List<Object?> get props => [];
}

class AllListNoDataState extends AllListState {
  @override
  List<Object?> get props => [];
}

class AllListErrorState extends AllListState {
  final String error;

  AllListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class AllListDataReceivedState extends AllListState {
  final List<ListItem> listItems;

  AllListDataReceivedState(this.listItems);

  @override
  List<Object?> get props => [listItems];
}

class AllListNavigationState extends AllListState implements NavigationState {
  @override
  final String destination;
  @override
  final dynamic args;

  @override
  String? popUntil;

  @override
  NavigationType? navigationType;

  AllListNavigationState(this.destination, this.args);

  @override
  List<Object> get props => [args, destination];
}
