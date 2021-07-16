import 'package:mafia/common/transform/game.dart';
import 'package:mafia/data/cache/game/game_cache.dart';
import 'package:mafia/data/db/dao/game_dao.dart';
import 'package:mafia/data/db/dao/occupation_dao.dart';
import 'package:mafia/data/model/game/game.dart' as dat;
import 'package:mafia/data/model/player/occupation.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/game/game.dart' as dom;
import 'package:mafia/domain/model/game/game.dart';
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/model/role/role.dart';

abstract class GameRepository {
  final GameDao dao;
  final OccupationDao occupationDao;
  final GameCache memoryCache;

  GameRepository(this.dao, this.occupationDao, this.memoryCache);

  Stream<ApiResource<List<dom.Game>>> getGames();

  Stream<ApiResource<List<dom.Game>>> getGamesByIds(List<int> ids);

  Stream<ApiResource<dom.Game>> getGame(int id);

  Stream<ApiResource<int>> insertGame(Game game);

  Stream<ApiResource<int>> newGame(List<Player> players, List<Role> roles);

  Stream<ApiResource<List<int>>> deleteGames(List<int> playerIds);
}

class GameRepositoryImpl extends GameRepository {
  GameRepositoryImpl(
    GameDao dao,
    OccupationDao occupationDao,
    GameCache memoryCache,
  ) : super(dao, occupationDao, memoryCache);

  @override
  Stream<ApiResource<List<dom.Game>>> getGames() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Game>> data =
        await (memoryCache.getGames() ?? dao.getAllFromDb())!
            .then((List<dat.Game>? value) {
      memoryCache.putGames(value);
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, error.toString());
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<dom.Game>>> getGamesByIds(List<int> ids) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Game>> data =
        await (memoryCache.getGamesByIds(ids) ?? dao.getAllFromDbByIds(ids))!
            .then((List<dat.Game>? value) {
      memoryCache.putGames(value);
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, error.toString());
    });

    yield data;
  }

  @override
  Stream<ApiResource<dom.Game>> getGame(int id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<dom.Game> data =
        await (memoryCache.getGame(id) ?? dao.getFromDb(id))!
            .then((dat.Game? value) {
      memoryCache.putGame(value);
      return ApiResource(Status.SUCCESS, value?.toDomain(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, error.toString());
    });

    yield data;
  }

  @override
  Stream<ApiResource<int>> insertGame(Game game) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<int> data = await dao
        .insert(dat.Game(game.id, null, DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch))
        .then((int value) {
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, error.toString());
    });

    yield data;
  }

  @override
  Stream<ApiResource<int>> newGame(
    List<Player> players,
    List<Role> roles,
  ) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<int> data = await dao
        .insert(dat.Game(-1, null, DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch))
        .then((int gameId) {
      /**
       * inserting 3 normal players for each mafia
       */
      final List<Occupation> occupations = [];
      int index = 0;

      players.forEach((player) {
        if (index != 0 && index % 3 == 0) {
          occupations.add(Occupation(
            -1,
            gameId,
            player.id,
            roles.where((element) => element.name == 'mafia').first.id,
            null,
            null,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch,
          ));
        } else {
          occupations.add(Occupation(
            -1,
            gameId,
            player.id,
            roles.where((element) => element.group.id == 2).first.id,
            null,
            null,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch,
          ));
        }
        index++;
      });

      occupations.forEach((occupation) {
        occupationDao.insert(occupation);
      });

      return ApiResource(Status.SUCCESS, gameId, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, error.toString());
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<int>>> deleteGames(List<int> playerIds) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<int>> data =
        await dao.deleteByIds(playerIds).then((value) {
      memoryCache.removeGamesByIds(playerIds);
      return ApiResource(Status.SUCCESS, value, null);
    });

    yield data;
  }
}
