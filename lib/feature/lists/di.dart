import 'package:mafia/app/di.dart';

import 'logic/all_list_cubit.dart';

void registerAllListPage() {
  serviceLocator.registerFactory<AllListCubit>(() => AllListCubit());
}
