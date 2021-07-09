import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/role/role.dart';
import 'package:mafia/domain/usecase/role/get_roles_usecase.dart';
import 'package:mafia/navigation/type.dart';

part 'role_list_state.dart';

class RoleListCubit extends PageCubit<RoleListState> {
  final GetRolesUseCase _getRolesUseCase;

  RoleListCubit(this._getRolesUseCase) : super(RoleListInitialState());

  List<Role>? roles;

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
            roles = event.data;
            emit(RoleListDataReceivedState(roles!));
          }
          break;

        case Status.ERROR:
          emit(RoleListErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(RoleListErrorState(e.toString()));
    });
  }

  List<Role>? getSelectedRoles() =>
      roles?.where((element) => element.isSelected).toList();

  void navigateToRoleDetails(Role coin) {
    //emit(RoleListNavigationState(NavigationRoutes.DETAILS, coin));
  }
}
