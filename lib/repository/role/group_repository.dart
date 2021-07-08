import 'package:dio/dio.dart';
import 'package:mafia/data/cache/role/group_cache.dart';
import 'package:mafia/data/db/dao/group_dao.dart';
import 'package:mafia/data/model/role/group.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';

abstract class GroupRepository {
  final GroupDao dao;
  final GroupCache memoryCache;

  GroupRepository(this.dao, this.memoryCache);

  Stream<ApiResource<List<Group>>> getGroups();

  Stream<ApiResource<Group>> getGroup(int id);
}

class GroupRepositoryImpl extends GroupRepository {
  GroupRepositoryImpl(GroupDao dao, GroupCache memoryCache)
      : super(dao, memoryCache);

  @override
  Stream<ApiResource<List<Group>>> getGroups() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<Group>> data =
        await (memoryCache.getGroups() ?? dao.getAllFromDb())!
            .then((List<Group>? value) {
      memoryCache.putGroups(value);
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<Group>> getGroup(int id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<Group> data =
        await (memoryCache.getGroup(id) ?? dao.getFromDb(id))!
            .then((Group? value) {
      memoryCache.putGroup(value);
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }
}
