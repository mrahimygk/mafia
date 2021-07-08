import 'package:mafia/data/model/role/role.dart';

abstract class RoleCache {
  Future<List<Role>>? getRoles();

  void putRoles(List<Role> roles);
}

class RoleCacheImpl extends RoleCache {
  Map<int, Role>? roles;

  @override
  Future<List<Role>>? getRoles() =>
      roles == null ? null : Future.value(roles!.values.toList());

  @override
  void putRoles(List<Role> roleList) {
    if (roles == null) {
      roles = Map<int, Role>();
    }
    roleList.forEach((element) {
      roles![element.id] = element;
    });
  }
}
