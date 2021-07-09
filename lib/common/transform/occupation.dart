import 'package:mafia/data/model/player/occupation.dart' as data;
import 'package:mafia/domain/model/player/occupation.dart' as domain;
import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/model/role/role.dart';

extension ToDomain on data.Occupation {
  domain.Occupation toDomain(Player player, Role role) => domain.Occupation(
        id,
        player,
        role,
        createdDate,
        modifiedDate,
      );
}
