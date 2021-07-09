import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/player_scope_dao.dart';

class PlayerScope {
  final int id;
  final String name;
  final int createdDate;
  final int modifiedDate;

  PlayerScope(
    this.id,
    this.name,
    this.createdDate,
    this.modifiedDate,
  );

  PlayerScope copyWith({
    int? id,
    String? name,
    int? createdDate,
    int? modifiedDate,
  }) =>
      PlayerScope(
        id ?? this.id,
        name ?? this.name,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  factory PlayerScope.fromMap(Map<String, dynamic> json) {
    return PlayerScope(
      json[playerScopeColumnId],
      json[playerScopeColumnName],
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[playerScopeColumnId] = id;
    data[playerScopeColumnName] = name;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
