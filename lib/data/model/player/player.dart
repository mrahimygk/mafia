import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/player_dao.dart';
import 'package:mafia/data/model/player/player_scope.dart';

class Player {
  final int id;
  final String name;
  final int scopeId;
  final PlayerScope? scope;
  final int createdDate;
  final int modifiedDate;

  Player(
    this.id,
    this.name,
    this.scopeId,
    this.scope,
    this.createdDate,
    this.modifiedDate,
  );

  Player copyWith({
    int? id,
    String? name,
    int? scopeId,
    PlayerScope? scope,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Player(
        id ?? this.id,
        name ?? this.name,
        scopeId ?? this.scopeId,
        scope ?? this.scope,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  factory Player.fromMap(Map<String, dynamic> json) {
    return Player(
      json[playerColumnId],
      json[playerColumnName],
      json[playerColumnScope],
      null,
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[playerColumnId] = id <= 0 ? null : id;
    data[playerColumnName] = name;
    data[playerColumnScope] = scopeId;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
