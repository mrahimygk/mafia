import 'package:dio/dio.dart';
import 'package:mafia/common/transform/role.dart';
import 'package:mafia/data/cache/role/role_cache.dart';
import 'package:mafia/data/db/dao/role_dao.dart';
import 'package:mafia/data/model/role/role.dart' as dat;
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/role/role.dart' as dom;

abstract class RoleRepository {
  final RoleDao dao;
  final RoleCache memoryCache;

  RoleRepository(this.dao, this.memoryCache);

  Stream<ApiResource<List<dom.Role>>> getRoles();

  Stream<ApiResource<List<dom.Role>>> getRolesByGroupId(int gid);

  Stream<ApiResource<dom.Role>> getRole(int id);
}

class RoleRepositoryImpl extends RoleRepository {
  RoleRepositoryImpl(RoleDao dao, RoleCache memoryCache)
      : super(dao, memoryCache);

  @override
  Stream<ApiResource<List<dom.Role>>> getRoles() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Role>> data =
        await (memoryCache.getRoles() ?? dao.getAllFromDb())!
            .then((List<dat.Role>? value) {
      memoryCache.putRoles(value);
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<dom.Role>>> getRolesByGroupId(int gid) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Role>> data =
        await (memoryCache.getRolesByGroupId(gid) ?? dao.getByGroupId(gid))!
            .then((List<dat.Role>? value) {
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<dom.Role>> getRole(int id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<dom.Role> data =
        await (memoryCache.getRole(id) ?? dao.getFromDb(id))!
            .then((dat.Role? value) {
      memoryCache.putRole(value);
      return ApiResource(Status.SUCCESS, value?.toDomain(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
