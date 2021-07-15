import 'package:mafia/domain/model/player/occupation.dart';

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
    List<Occupation>? occupations,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Game(
        id ?? this.id,
        occupations ?? this.occupations,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );
}
