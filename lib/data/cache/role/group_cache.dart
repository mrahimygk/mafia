import 'package:mafia/data/model/role/group.dart';

abstract class GroupCache {
  Future<List<Group>?>? getGroups();

  Future<Group?>? getGroup(int id);

  void putGroups(List<Group>? items);

  void putGroup(Group? item);
}

class GroupCacheImpl extends GroupCache {
  Map<int, Group>? cache;

  @override
  Future<List<Group>>? getGroups() =>
      cache == null ? null : Future.value(cache!.values.toList());

  @override
  void putGroups(List<Group>? list) {
    if (cache == null) {
      cache = Map<int, Group>();
    }
    list?.forEach((element) {
      cache?[element.id] = element;
    });
  }

  @override
  Future<Group?>? getGroup(int id) =>
      cache == null ? null : Future.value(cache![id]);

  @override
  void putGroup(Group? item) {
    if (cache == null) {
      cache = Map<int, Group>();
    }

    if (item == null) return;
    cache?[item.id] = item;
  }
}
