import 'package:mafia/data/model/player/occupation.dart';

abstract class OccupationCache {
  Future<List<Occupation>?>? getOccupations();

  Future<List<Occupation>?>? getOccupationsByIds(List<int> ids);

  Future<Occupation?>? getOccupation(int id);

  void putOccupations(List<Occupation>? list);

  void putOccupation(Occupation? item);

  void removeOccupationsByIds(List<int> ids);
}

class OccupationCacheImpl extends OccupationCache {
  Map<int, Occupation>? cache;

  @override
  Future<List<Occupation>>? getOccupations() =>
      cache == null ? null : Future.value(cache!.values.toList());

  @override
  Future<List<Occupation>>? getOccupationsByIds(List<int> ids) {
    final data =
        cache!.values.where((element) => ids.contains(element.id)).toList();
    return cache == null
        ? null
        : data.isEmpty
            ? null
            : Future.value(data);
  }

  @override
  void putOccupations(List<Occupation>? list) {
    if (cache == null) {
      cache = Map<int, Occupation>();
    }
    list?.forEach((element) {
      cache?[element.id] = element;
    });
  }

  @override
  Future<Occupation?>? getOccupation(int id) =>
      cache == null ? null : cache!.containsKey(id)
          ?Future.value(cache![id]):null;

  @override
  void putOccupation(Occupation? item) {
    if (cache == null) {
      cache = Map<int, Occupation>();
    }

    if (item == null) return;
    cache?[item.id] = item;
  }

  @override
  void removeOccupationsByIds(List<int> ids) {
    ids.forEach((element) {
      cache?.remove(element);
    });
  }
}
