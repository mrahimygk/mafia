import 'package:mafia/data/model/role/role.dart';

abstract class RoleCache {
  Future<List<Role>?>? getRoles();

  Future<Role?>? getRole(int id);

  void putRoles(List<Role>? roles);

  void putRole(Role? role);
}

class RoleCacheImpl extends RoleCache {
  Map<int, Role>? roles;

  @override
  Future<List<Role>>? getRoles() =>
      roles == null ? null : Future.value(roles!.values.toList());

  @override
  void putRoles(List<Role>? roleList) {
    if (roles == null) {
      roles = Map<int, Role>();
    }
    roleList?.forEach((element) {
      roles?[element.id] = element;
    });
  }

  @override
  Future<Role?>? getRole(int id) =>
      roles == null ? null : Future.value(roles![id]);

  @override
  void putRole(Role? role) {
    if (roles == null) {
      roles = Map<int, Role>();
    }

    if (role == null) return;
    roles?[role.id] = role;
  }
}
