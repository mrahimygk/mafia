import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/game_dao.dart';
import 'package:mafia/data/model/player/occupation.dart';

class Game {
  final int id;
  final List<Occupation>? occupations;
  final int createdDate;
  final int modifiedDate;

  Game(
    this.id,
    this.occupations,
    this.createdDate,
    this.modifiedDate,
  );

  Game copyWith({
    int? id,
    int? createdDate,
    List<Occupation>? occupations,
    int? modifiedDate,
  }) =>
      Game(
        id ?? this.id,
        occupations ?? this.occupations,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  factory Game.fromMap(Map<String, dynamic> json) {
    return Game(
      json[gameColumnId],
      null,
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[gameColumnId] = id <= 0 ? null : id;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
