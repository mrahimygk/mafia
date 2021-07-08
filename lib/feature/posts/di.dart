import 'package:mafia/app/di.dart';
import 'package:mafia/domain/usecase/get_posts_usecase.dart';
import 'package:mafia/feature/posts/logic/post_list_cubit.dart';

void registerPostListPage() {
  serviceLocator.registerFactory<PostListCubit>(
      () => PostListCubit(serviceLocator.get<GetPostsUseCase>()));
}