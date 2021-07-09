import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/role_dao.dart';
import 'package:mafia/data/model/role/group.dart';

class Role {
  final int id;
  final String name;
  final String description;
  final int groupId;
  Group? group;
  final int createdDate;
  final int modifiedDate;

  Role(
    this.id,
    this.name,
    this.description,
    this.groupId,
    this.group,
    this.createdDate,
    this.modifiedDate,
  );

  Role copyWith({
    int? id,
    String? name,
    String? description,
    int? groupId,
    Group? group,
    int? createdDate,
    int? modifiedDate,
  }) =>
      Role(
        id ?? this.id,
        name ?? this.name,
        description ?? this.description,
        groupId ?? this.groupId,
        group ?? this.group,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  factory Role.fromMap(Map<String, dynamic> json) {
    return Role(
      json[roleColumnId],
      json[roleColumnName],
      json[roleColumnDescription],
      json[roleColumnGroupId],
      null,
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[roleColumnId] = id;
    data[roleColumnName] = name;
    data[roleColumnDescription] = description;
    data[roleColumnGroupId] = groupId;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
