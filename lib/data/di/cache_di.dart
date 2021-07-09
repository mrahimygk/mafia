import 'package:mafia/app/di.dart';
import 'package:mafia/data/cache/player/player_cache.dart';
import 'package:mafia/data/cache/role/group_cache.dart';
import 'package:mafia/data/cache/role/role_cache.dart';

void registerCacheModule() {
  serviceLocator.registerSingleton<GroupCache>(GroupCacheImpl());
  serviceLocator.registerSingleton<RoleCache>(RoleCacheImpl());
  serviceLocator.registerSingleton<PlayerCache>(PlayerCacheImpl());
}
