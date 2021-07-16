import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/occupation_dao.dart';
import 'package:mafia/data/model/player/player.dart';
import 'package:mafia/data/model/role/role.dart';

class Occupation {
  final int id;
  final int gameId;
  final int playerId;
  final int roleId;
  Player? player;
  Role? role;
  final int createdDate;
  final int modifiedDate;

  Occupation(
    this.id,
    this.gameId,
    this.playerId,
    this.roleId,
    this.player,
    this.role,
    this.createdDate,
    this.modifiedDate,
  );

  Occupation copyWith({
    int? id,
    int? gameId,
    int? playerId,
    int? roleId,
    Player? player,
    Role? role,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Occupation(
        id ?? this.id,
        gameId ?? this.gameId,
        playerId ?? this.playerId,
        roleId ?? this.roleId,
        player ?? this.player,
        role ?? this.role,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  factory Occupation.fromMap(Map<String, dynamic> json) {
    return Occupation(
      json[occupationColumnId],
      json[occupationColumnGameId],
      json[occupationColumnPlayerId],
      json[occupationColumnRoleId],
      null,
      null,
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[occupationColumnId] = id <= 0 ? null : id;
    data[occupationColumnGameId] = gameId;
    data[occupationColumnPlayerId] = playerId;
    data[occupationColumnRoleId] = roleId;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
