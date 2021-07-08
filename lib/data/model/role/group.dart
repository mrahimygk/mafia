import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/role_dao.dart';

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

  factory Group.fromMap(Map<String, dynamic> json) {
    return Group(
      json[roleColumnId],
      json[roleColumnName],
      json[tableColumnCreatedDate],
      json[tableColumnModifiedDate],
    );
  }

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[roleColumnId] = id;
    data[roleColumnName] = name;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;
    return data;
  }
}
