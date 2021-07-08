import 'package:mafia/domain/base/base_use_case.dart';
import 'package:mafia/domain/model/base/api_resource.dart';
import 'package:mafia/domain/model/post/post.dart';
import 'package:mafia/repository/posts_repository.dart';

abstract class GetPostsUseCase extends BaseUseCase<void, List<Post>> {
  final PostsRepository _postsRepository;

  GetPostsUseCase(this._postsRepository);
}

class GetPostsUseCaseImpl extends GetPostsUseCase {
  GetPostsUseCaseImpl(PostsRepository postsRepository)
      : super(postsRepository);

  @override
  Stream<ApiResource<List<Post>>> execute(void request) =>
      _postsRepository.getPosts();
}
