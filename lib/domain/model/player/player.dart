import 'package:mafia/domain/model/player/player_scope.dart';

class Player {
  final int id;
  final String name;
  final PlayerScope? scope;
  bool isSelected = false;
  final int createdDate;
  final int modifiedDate;

  Player(
    this.id,
    this.name,
    this.scope,
    this.isSelected,
    this.createdDate,
    this.modifiedDate,
  );

  Player copyWith({
    int? id,
    String? name,
    PlayerScope? scope,
    bool? isSelected,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Player(
        id ?? this.id,
        name ?? this.name,
        scope ?? this.scope,
        isSelected ?? this.isSelected,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );
}
