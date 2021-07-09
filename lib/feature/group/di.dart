import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/role/get_groups_usecase.dart';

import 'logic/group_list_cubit.dart';

void registerGroupListPage() {
  serviceLocator.registerFactory<GroupListCubit>(
      () => GroupListCubit(serviceLocator.get<GetGroupsUseCase>()));
}
