import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/role/get_roles_usecase.dart';

import 'logic/role_list_cubit.dart';

void registerRoleListPage() {
  serviceLocator.registerFactory<RoleListCubit>(() => RoleListCubit(
        serviceLocator.get<GetRolesUseCase>(),
      ));
}
