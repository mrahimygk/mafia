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
}
