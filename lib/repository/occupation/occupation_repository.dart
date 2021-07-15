import 'package:dio/dio.dart';
import 'package:mafia/common/transform/occupation.dart';
import 'package:mafia/data/cache/occupation/occupation_cache.dart';
import 'package:mafia/data/db/dao/occupation_dao.dart';
import 'package:mafia/data/model/player/occupation.dart' as dat;
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/player/occupation.dart' as dom;

abstract class OccupationRepository {
  final OccupationDao dao;
  final OccupationCache memoryCache;

  OccupationRepository(this.dao, this.memoryCache);

  Stream<ApiResource<List<dom.Occupation>>> getOccupations();

  Stream<ApiResource<List<dom.Occupation>>> getOccupationsByIds(List<int> ids);

  Stream<ApiResource<dom.Occupation>> getOccupation(int id);

  Stream<ApiResource<int>> insertOccupation(int playerId, int roleId);

  Stream<ApiResource<List<int>>> deleteOccupations(List<int> ids);
}

class OccupationRepositoryImpl extends OccupationRepository {
  OccupationRepositoryImpl(OccupationDao dao, OccupationCache memoryCache)
      : super(dao, memoryCache);

  @override
  Stream<ApiResource<List<dom.Occupation>>> getOccupations() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Occupation>> data =
        await (memoryCache.getOccupations() ?? dao.getAllFromDb())!
            .then((List<dat.Occupation>? value) {
      memoryCache.putOccupations(value);
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<dom.Occupation>>> getOccupationsByIds(
      List<int> ids) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Occupation>> data =
        await (memoryCache.getOccupationsByIds(ids) ??
                dao.getAllFromDbByIds(ids))!
            .then((List<dat.Occupation>? value) {
      memoryCache.putOccupations(value);
      return ApiResource(
          Status.SUCCESS, value?.map((e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<dom.Occupation>> getOccupation(int id) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<dom.Occupation> data =
        await (memoryCache.getOccupation(id) ?? dao.getFromDb(id))!
            .then((dat.Occupation? value) {
      memoryCache.putOccupation(value);
      return ApiResource(Status.SUCCESS, value?.toDomain(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<int>> insertOccupation(int playerId, int roleId) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<int> data = await dao
        .insert(dat.Occupation(
            -1,
            playerId,
            roleId,
            null,
            null,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch))
        .then((int value) {
      return ApiResource(Status.SUCCESS, value, null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<List<int>>> deleteOccupations(List<int> ids) async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<int>> data =
        await dao.deleteByIds(ids).then((value) {
      memoryCache.removeOccupationsByIds(ids);
      return ApiResource(Status.SUCCESS, value, null);
    });

    yield data;
  }
}
