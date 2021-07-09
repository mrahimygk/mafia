import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/occupation_dao.dart';

class Occupation {
  final int id;
  final int playerId;
  final int roleId;
  final int createdDate;
  final int modifiedDate;

  Occupation(
    this.id,
    this.playerId,
    this.roleId,
    this.createdDate,
    this.modifiedDate,
  );

  Occupation copyWith({
    int? id,
    int? playerId,
    int? roleId,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Occupation(
        id ?? this.id,
        playerId ?? this.playerId,
        roleId ?? this.roleId,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  factory Occupation.fromMap(Map<String, dynamic> json) {
    return Occupation(
      json[occupationColumnId],
      json[occupationColumnPlayerId],
      json[occupationColumnRoleId],
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[occupationColumnId] = id;
    data[occupationColumnPlayerId] = playerId;
    data[occupationColumnRoleId] = roleId;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
