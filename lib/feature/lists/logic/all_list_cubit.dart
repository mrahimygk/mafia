import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/feature/lists/data/items.dart';
import 'package:mafia/navigation/type.dart';

part 'all_list_state.dart';

class AllListCubit extends PageCubit<AllListState> {
  /*final GetPlayersUseCase _getPlayersUseCase;
  final GetGroupsUseCase _getGroupsUseCase;
  final GetRolesUseCase _getRolesUseCase;*/

  AllListCubit(
      /*this._getPlayersUseCase,
    this._getGroupsUseCase,
    this._getRolesUseCase,*/
      )
      : super(AllListInitialState());

  void getAllList() {
    emit(AllListLoadingState());

    emit(AllListDataReceivedState(listItems));
  }
}
