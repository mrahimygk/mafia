import 'package:mafia/common/base/page_cubit.dart';
import 'package:mafia/common/base/page_state.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/role/role.dart';
import 'package:mafia/domain/usecase/role/get_role_by_id_usecase.dart';
import 'package:mafia/navigation/type.dart';

part 'role_details_state.dart';

class RoleDetailsCubit extends PageCubit<RoleDetailsState> {
  final GetRoleByIdUseCase _getRoleByIdUseCase;

  RoleDetailsCubit(this._getRoleByIdUseCase) : super(RoleDetailsInitialState());

  void getRoleDetails(Role role, bool hasError) {
    if (!hasError) {
      emit(RoleDetailsPreloadedState(role));
    }

    _getRoleByIdUseCase.execute(role.id).listen((ApiResource<Role> event) {
      switch (event.status) {
        case Status.LOADING:
          if (hasError) {
            emit(RoleDetailsLoadingState());
          } else {
            emit(RoleDetailsPreloadedState(role));
          }
          break;
        case Status.SUCCESS:
          if (event.data == null) {
            emit(RoleDetailsPreloadedState(role));
          } else {
            emit(RoleDetailsDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(RoleDetailsErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(RoleDetailsErrorState(e.toString()));
    });
  }
}
