import 'package:dio/dio.dart';
import 'package:mafia/common/transform/player.dart';
import 'package:mafia/data/cache/player/player_cache.dart';
import 'package:mafia/data/db/dao/player_dao.dart';
import 'package:mafia/data/model/player/player.dart' as dat;
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/player/player.dart' as dom;

abstract class PlayerRepository {
  final PlayerDao dao;
  final PlayerCache memoryCache;

  PlayerRepository(this.dao, this.memoryCache);

  Stream<ApiResource<List<dom.Player>>> getPlayers();

  Stream<ApiResource<List<dom.Player>>> getPlayersByIds(List<int> ids);

  Stream<ApiResource<dom.Player>> getPlayer(int id);

  Stream<ApiResource<int>> insertPlayer(String name);

  Stream<ApiResource<List<int>>> deletePlayers(List<int> playerIds);
}

class PlayerRepositoryImpl extends PlayerRepository {
  PlayerRepositoryImpl(PlayerDao dao, PlayerCache memoryCache)
      : super(dao, memoryCache);

  @override
  Stream<ApiResource<List<dom.Player>>> getPlayers() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Player>> data =
        await (memoryCache.getPlayers() ?? dao.getAllFromDb())!
            .then((List<dat.Player>? value) {
      memoryCache.putPlayers(value);
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<dom.Player>>> getPlayersByIds(List<int> ids) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Player>> data =
        await (memoryCache.getPlayersByIds(ids) ?? dao.getAllFromDbByIds(ids))!
            .then((List<dat.Player>? value) {
      memoryCache.putPlayers(value);
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<dom.Player>> getPlayer(int id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<dom.Player> data =
        await (memoryCache.getPlayer(id) ?? dao.getFromDb(id))!
            .then((dat.Player? value) {
      memoryCache.putPlayer(value);
      return ApiResource(Status.SUCCESS, value?.toDomain(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<int>> insertPlayer(String name) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<int> data = await dao
        .insert(dat.Player(
            -1,
            name,
            1,
            null,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch))
        .then((int value) {
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<int>>> deletePlayers(List<int> playerIds) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<int>> data = await dao.deleteByIds(playerIds).then((value) {
      memoryCache.removePlayersByIds(playerIds);
      return ApiResource(Status.SUCCESS, value, null);
    });/*.onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });*/

    yield data;
  }
}
