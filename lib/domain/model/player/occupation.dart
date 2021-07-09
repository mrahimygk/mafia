import 'package:mafia/domain/model/player/player.dart';
import 'package:mafia/domain/model/role/role.dart';

class Occupation {
  final int id;
  final Player player;
  final Role role;
  final int createdDate;
  final int modifiedDate;

  Occupation(
    this.id,
    this.player,
    this.role,
    this.createdDate,
    this.modifiedDate,
  );

  Occupation copyWith({
    int? id,
    Player? player,
    Role? role,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Occupation(
        id ?? this.id,
        player ?? this.player,
        role ?? this.role,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );
}
