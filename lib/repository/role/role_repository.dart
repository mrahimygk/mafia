import 'package:dio/dio.dart';
import 'package:mafia/data/cache/role/role_cache.dart';
import 'package:mafia/data/db/dao/role_dao.dart';
import 'package:mafia/data/model/role/role.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';

abstract class RoleRepository {
  final RoleDao dao;
  final RoleCache memoryCache;

  RoleRepository(this.dao, this.memoryCache);

  Stream<ApiResource<List<Role>>> getRoles();

  Stream<ApiResource<Role>> getRole(int id);
}

class RoleRepositoryImpl extends RoleRepository {
  RoleRepositoryImpl(RoleDao dao, RoleCache memoryCache)
      : super(dao, memoryCache);

  @override
  Stream<ApiResource<List<Role>>> getRoles() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<Role>> data =
        await (memoryCache.getRoles() ?? dao.getAllFromDb())!
            .then((List<Role>? value) {
      memoryCache.putRoles(value);
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<Role>> getRole(int id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<Role> data =
        await (memoryCache.getRole(id) ?? dao.getFromDb(id))!
            .then((Role? value) {
      memoryCache.putRole(value);
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
