import 'package:mafia/app/di.dart';
import 'package:mafia/data/db/dao/group_dao.dart';
import 'package:mafia/data/db/dao/occupation_dao.dart';
import 'package:mafia/data/db/dao/player_dao.dart';
import 'package:mafia/data/db/dao/player_scope_dao.dart';
import 'package:mafia/data/db/dao/prefs_data_dao.dart';
import 'package:mafia/data/db/dao/role_dao.dart';

import 'dao/game_dao.dart';
import 'database_provider.dart';

void registerDbModule() {
  serviceLocator.registerSingleton(DatabaseProvider.get);

  serviceLocator
      .registerSingleton(PrefsDataDao(serviceLocator.get<DatabaseProvider>()));

  serviceLocator
      .registerSingleton(GroupDao(serviceLocator.get<DatabaseProvider>()));

  serviceLocator
      .registerSingleton(PlayerScopeDao(serviceLocator.get<DatabaseProvider>()));

  serviceLocator.registerSingleton(PlayerDao(
    serviceLocator.get<DatabaseProvider>(),
    serviceLocator.get<PlayerScopeDao>(),
  ));

  serviceLocator.registerSingleton(
    RoleDao(
      serviceLocator.get<DatabaseProvider>(),
      serviceLocator.get<GroupDao>(),
    ),
  );

  serviceLocator.registerSingleton(
    OccupationDao(
      serviceLocator.get<DatabaseProvider>(),
      serviceLocator.get<RoleDao>(),
      serviceLocator.get<PlayerDao>(),
    ),
  );

  serviceLocator.registerSingleton(GameDao(
      serviceLocator.get<DatabaseProvider>(),
      serviceLocator.get<OccupationDao>()
  ));

}
