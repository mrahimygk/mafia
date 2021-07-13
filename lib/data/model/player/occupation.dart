import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/occupation_dao.dart';
import 'package:mafia/data/model/player/player.dart';
import 'package:mafia/data/model/role/role.dart';

class Occupation {
  final int id;
  final int playerId;
  final int roleId;
  Player? player;
  Role? role;
  final int createdDate;
  final int modifiedDate;

  Occupation(
    this.id,
    this.playerId,
    this.roleId,
    this.player,
    this.role,
    this.createdDate,
    this.modifiedDate,
  );

  Occupation copyWith({
    int? id,
    int? playerId,
    int? roleId,
    Player? player,
    Role? role,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Occupation(
        id ?? this.id,
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
    data[occupationColumnPlayerId] = playerId;
    data[occupationColumnRoleId] = roleId;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
