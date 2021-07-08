import 'package:mafia/app/di.dart';
import 'package:mafia/data/db/dao/group_dao.dart';
import 'package:mafia/data/db/dao/prefs_data_dao.dart';
import 'package:mafia/data/db/dao/role_dao.dart';

import 'database_provider.dart';

void registerDbModule() {
  serviceLocator.registerSingleton(DatabaseProvider.get);

  serviceLocator
      .registerSingleton(PrefsDataDao(serviceLocator.get<DatabaseProvider>()));

  serviceLocator
      .registerSingleton(GroupDao(serviceLocator.get<DatabaseProvider>()));

  serviceLocator
      .registerSingleton(RoleDao(serviceLocator.get<DatabaseProvider>()));
}
