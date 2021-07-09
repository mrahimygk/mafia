import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/player_dao.dart';

class Player {
  final int id;
  final String name;
  final int createdDate;
  final int modifiedDate;

  Player(
    this.id,
    this.name,
    this.createdDate,
    this.modifiedDate,
  );

  Player copyWith({
    int? id,
    String? name,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Player(
        id ?? this.id,
        name ?? this.name,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  factory Player.fromMap(Map<String, dynamic> json) {
    return Player(
      json[playerColumnId],
      json[playerColumnName],
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[playerColumnId] = id;
    data[playerColumnName] = name;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
