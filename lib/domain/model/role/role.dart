import 'package:mafia/domain/model/role/group.dart';

class Role {
  final int id;
  final String name;
  final String description;
  final Group group;
  bool isSelected = false;
  final int createdDate;
  final int modifiedDate;

  Role(
    this.id,
    this.name,
    this.description,
    this.group,
    this.isSelected,
    this.createdDate,
    this.modifiedDate,
  );

  Role copyWith({
    int? id,
    String? name,
    String? description,
    Group? group,
    bool? isSelected,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Role(
        id ?? this.id,
        name ?? this.name,
        description ?? this.description,
        group ?? this.group,
        isSelected ?? this.isSelected,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );
}
