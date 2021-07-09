import 'package:mafia/data/model/role/role.dart';

abstract class RoleCache {
  Future<List<Role>?>? getRoles();

  Future<List<Role>?>? getRolesByGroupId(int gid);

  Future<Role?>? getRole(int id);

  void putRoles(List<Role>? list);

  void putRole(Role? item);
}

class RoleCacheImpl extends RoleCache {
  Map<int, Role>? cache;

  @override
  Future<List<Role>>? getRoles() =>
      cache == null ? null : Future.value(cache!.values.toList());

  @override
  Future<List<Role>>? getRolesByGroupId(int gid) => cache == null
      ? null
      : Future.value(
          cache!.values.where((element) {
            return element.groupId == gid;
          }).toList(),
        );

  @override
  void putRoles(List<Role>? list) {
    if (cache == null) {
      cache = Map<int, Role>();
    }
    list?.forEach((element) {
      cache?[element.id] = element;
    });
  }

  @override
  Future<Role?>? getRole(int id) =>
      cache == null ? null : Future.value(cache![id]);

  @override
  void putRole(Role? item) {
    if (cache == null) {
      cache = Map<int, Role>();
    }

    if (item == null) return;
    cache?[item.id] = item;
  }
}
