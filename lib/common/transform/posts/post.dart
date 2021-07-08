
import 'package:mafia/data/model/post/post.dart' as data;
import 'package:mafia/domain/model/post/post.dart' as domain;

extension ToDomain on data.Post {
  domain.Post toDomain() => domain.Post(
    id,
    userId,
    title,
    body
  );
}