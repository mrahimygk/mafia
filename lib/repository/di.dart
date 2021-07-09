import 'package:mafia/app/di.dart';
import 'package:mafia/data/cache/player/player_cache.dart';
import 'package:mafia/data/cache/role/group_cache.dart';
import 'package:mafia/data/cache/role/role_cache.dart';
import 'package:mafia/data/db/dao/group_dao.dart';
import 'package:mafia/data/db/dao/player_dao.dart';
import 'package:mafia/data/db/dao/role_dao.dart';
import 'package:mafia/repository/player/player_repository.dart';
import 'package:mafia/repository/role/group_repository.dart';
import 'package:mafia/repository/role/role_repository.dart';

void registerRepositoryModule() {
  serviceLocator.registerFactory<GroupRepository>(() => GroupRepositoryImpl(
        serviceLocator.get<GroupDao>(),
        serviceLocator.get<GroupCache>(),
      ));

  serviceLocator.registerFactory<RoleRepository>(() => RoleRepositoryImpl(
        serviceLocator.get<RoleDao>(),
        serviceLocator.get<RoleCache>(),
      ));

  serviceLocator.registerFactory<PlayerRepository>(() => PlayerRepositoryImpl(
        serviceLocator.get<PlayerDao>(),
        serviceLocator.get<PlayerCache>(),
      ));
}
