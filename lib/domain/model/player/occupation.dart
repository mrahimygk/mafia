import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/model/role/role.dart';

class Occupation {
  final int id;
  final int gameId;
  final Player player;
  final Role role;
  final int createdDate;
  final int modifiedDate;

  Occupation(
    this.id,
    this.gameId,
    this.player,
    this.role,
    this.createdDate,
    this.modifiedDate,
  );

  Occupation copyWith({
    int? id,
    int? gameId,
    Player? player,
    Role? role,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Occupation(
        id ?? this.id,
        gameId ?? this.gameId,
        player ?? this.player,
        role ?? this.role,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );
}
