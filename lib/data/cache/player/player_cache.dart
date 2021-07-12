import 'package:mafia/data/model/player/player.dart';

abstract class PlayerCache {
  Future<List<Player>?>? getPlayers();

  Future<List<Player>?>? getPlayersByIds(List<int> ids);

  Future<Player?>? getPlayer(int id);

  void putPlayers(List<Player>? list);

  void putPlayer(Player? item);
}

class PlayerCacheImpl extends PlayerCache {
  Map<int, Player>? cache;

  @override
  Future<List<Player>>? getPlayers() =>
      cache == null ? null : Future.value(cache!.values.toList());

  @override
  Future<List<Player>>? getPlayersByIds(List<int> ids) {
    final data =
        cache!.values.where((element) => ids.contains(element.id)).toList();
    return cache == null
        ? null
        : data.isEmpty
            ? null
            : Future.value(data);
  }

  @override
  void putPlayers(List<Player>? list) {
    if (cache == null) {
      cache = Map<int, Player>();
    }
    list?.forEach((element) {
      cache?[element.id] = element;
    });
  }

  @override
  Future<Player?>? getPlayer(int id) =>
      cache == null ? null : Future.value(cache![id]);

  @override
  void putPlayer(Player? item) {
    if (cache == null) {
      cache = Map<int, Player>();
    }

    if (item == null) return;
    cache?[item.id] = item;
  }
}
