import 'package:dio/dio.dart';
import 'package:mafia/data/cache/player/player_cache.dart';
import 'package:mafia/data/db/dao/player_dao.dart';
import 'package:mafia/data/model/player/player.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';

abstract class PlayerRepository {
  final PlayerDao dao;
  final PlayerCache memoryCache;

  PlayerRepository(this.dao, this.memoryCache);

  Stream<ApiResource<List<Player>>> getPlayers();

  Stream<ApiResource<Player>> getPlayer(int id);
}

class PlayerRepositoryImpl extends PlayerRepository {
  PlayerRepositoryImpl(PlayerDao dao, PlayerCache memoryCache)
      : super(dao, memoryCache);

  @override
  Stream<ApiResource<List<Player>>> getPlayers() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<Player>> data =
        await (memoryCache.getPlayers() ?? dao.getAllFromDb())!
            .then((List<Player>? value) {
      memoryCache.putPlayers(value);
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<Player>> getPlayer(int id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<Player> data =
        await (memoryCache.getPlayer(id) ?? dao.getFromDb(id))!
            .then((Player? value) {
      memoryCache.putPlayer(value);
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
