class Group {
  final int id;
  final String name;
  final int createdDate;
  final int modifiedDate;

  Group(
    this.id,
    this.name,
    this.createdDate,
    this.modifiedDate,
  );

  Group copyWith({
    int? id,
    String? name,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Group(
        id ?? this.id,
        name ?? this.name,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );
}
