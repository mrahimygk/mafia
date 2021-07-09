import 'package:mafia/data/model/player/player.dart' as data;
import 'package:mafia/domain/model/player/player.dart' as domain;

import './player_scope.dart';

extension ToDomain on data.Player {
  domain.Player toDomain() => domain.Player(
        id,
        name,
        scope?.toDomain(),
        false,
        createdDate,
        modifiedDate,
      );
}
