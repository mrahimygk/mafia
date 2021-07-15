import 'package:mafia/data/model/game/game.dart' as data;
import 'package:mafia/domain/model/game/game.dart' as domain;

import './occupation.dart';

extension ToDomain on data.Game {
  domain.Game toDomain() => domain.Game(
        id,
        occupations?.map((e) => e.toDomain()).toList(),
        createdDate,
        modifiedDate,
      );
}
