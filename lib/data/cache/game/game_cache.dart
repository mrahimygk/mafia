import 'package:mafia/data/model/game/game.dart';

abstract class GameCache {
  Future<List<Game>?>? getGames();

  Future<List<Game>?>? getGamesByIds(List<int> ids);

  Future<Game?>? getGame(int id);

  void putGames(List<Game>? list);

  void putGame(Game? item);

  void removeGamesByIds(List<int> playerIds);
}

class GameCacheImpl extends GameCache {
  Map<int, Game>? cache;

  @override
  Future<List<Game>>? getGames() =>
      cache == null ? null : Future.value(cache!.values.toList());

  @override
  Future<List<Game>>? getGamesByIds(List<int> ids) {
    final data =
        cache!.values.where((element) => ids.contains(element.id)).toList();
    return cache == null
        ? null
        : data.isEmpty
            ? null
            : Future.value(data);
  }

  @override
  void putGames(List<Game>? list) {
    if (cache == null) {
      cache = Map<int, Game>();
    }
    list?.forEach((element) {
      cache?[element.id] = element;
    });
  }

  @override
  Future<Game?>? getGame(int id) => cache == null
      ? null
      : cache!.containsKey(id)
          ? Future.value(cache![id])
          : null;

  @override
  void putGame(Game? item) {
    if (cache == null) {
      cache = Map<int, Game>();
    }

    if (item == null) return;
    cache?[item.id] = item;
  }

  @override
  void removeGamesByIds(List<int> playerIds) {
    playerIds.forEach((element) {
      cache?.remove(element);
    });
  }
}
