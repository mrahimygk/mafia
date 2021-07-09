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
}
