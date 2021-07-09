import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/data/model/role/group.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/usecase/role/get_groups_usecase.dart';
import 'package:mafia/navigation/type.dart';

part 'group_list_state.dart';

class GroupListCubit extends PageCubit<GroupListState> {
  final GetGroupsUseCase _getGroupsUseCase;

  GroupListCubit(this._getGroupsUseCase) : super(GroupListInitialState());

  void getGroupList() {
    _getGroupsUseCase.execute(null).listen((ApiResource<List<Group>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(GroupListLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(GroupListNoDataState());
          } else {
            emit(GroupListDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(GroupListErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(GroupListErrorState(e.toString()));
    });
  }

  void navigateToGroupDetails(Group player) {
    //emit(GroupListNavigationState(NavigationRoutes.DETAILS, player));
  }
}
