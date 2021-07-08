import 'package:dio/dio.dart';
import 'package:mafia/common/transform/posts/post.dart';
import 'package:mafia/data/api/posts_api.dart';
import 'package:mafia/data/model/post/post.dart' as dat;
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/base/status.dart';
import 'package:mafia/domain/model/post/post.dart' as dom;

abstract class PostsRepository {
  final PostsApi _postsApi;

  PostsRepository(this._postsApi);

  Stream<ApiResource<List<dom.Post>>> getPosts();

  Stream<ApiResource<dom.Post>> getPostById(String id);
}

class PostsRepositoryImpl extends PostsRepository {
  PostsRepositoryImpl(PostsApi postsApi) : super(postsApi);

  @override
  Stream<ApiResource<List<dom.Post>>> getPosts() async* {
    yield ApiResource(Status.LOADING, null, null);

    final ApiResource<List<dom.Post>> data =
        await _postsApi.getPosts().then((List<dat.Post> value) {
      return ApiResource(Status.SUCCESS,
          value.map((dat.Post e) => e.toDomain()).toList(), null);
    }).onError((error, stackTrace) {
      return ApiResource(Status.ERROR, null, (error as DioError).message);
    });

    yield data;
  }

  @override
  Stream<ApiResource<dom.Post>> getPostById(String id) async* {
    yield ApiResource(Status.LOADING, null, null);

    throw UnimplementedError();
  }
}
