import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/role/get_role_by_id_usecase.dart';

import './logic/role_details_cubit.dart';

void registerRoleDetailsPage() {
  serviceLocator.registerFactory<RoleDetailsCubit>(() => RoleDetailsCubit(
        serviceLocator.get<GetRoleByIdUseCase>(),
      ));
}
