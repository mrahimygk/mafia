import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/data/model/role/role.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/usecase/role/get_roles_usecase.dart';
import 'package:mafia/navigation/routes.dart';
import 'package:mafia/navigation/type.dart';

part 'role_list_state.dart';

class RoleListCubit extends PageCubit<RoleListState> {
  final GetRolesUseCase _getRolesUseCase;

  RoleListCubit(this._getRolesUseCase) : super(RoleListInitialState());

  void getRoleList() {
    _getRolesUseCase.execute(null).listen((ApiResource<List<Role>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(RoleListLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(RoleListNoDataState());
          } else {
            emit(RoleListDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(RoleListErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(RoleListErrorState(e.toString()));
    });
  }

  void navigateToRoleDetails(Role coin) {
    emit(RoleListNavigationState(NavigationRoutes.COIN_DETAILS, coin));
  }
}
