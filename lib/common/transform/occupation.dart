import 'package:mafia/data/model/player/occupation.dart' as data;
import 'package:mafia/domain/model/player/occupation.dart' as domain;

import './player.dart';
import './role.dart';

extension ToDomain on data.Occupation {
  domain.Occupation toDomain() => domain.Occupation(
        id,
        gameId,
        player!.toDomain(),
        role!.toDomain(),
        createdDate,
        modifiedDate,
      );
}
