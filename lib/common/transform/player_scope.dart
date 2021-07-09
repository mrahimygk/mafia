import 'package:mafia/data/model/player/player_scope.dart' as data;
import 'package:mafia/domain/model/player/player_scope.dart' as domain;

extension ToDomain on data.PlayerScope {
  domain.PlayerScope toDomain() => domain.PlayerScope(
        id,
        name,
        createdDate,
        modifiedDate,
      );
}
