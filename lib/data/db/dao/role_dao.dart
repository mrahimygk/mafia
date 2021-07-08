import 'package:mafia/data/model/role/role.dart';

import 'dao.dart';

class RoleDao implements BaseDao<Role> {
  @override
  String get createTableQuery => 'CREATE TABLE $roleTable ('
      '$roleColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$roleColumnName TEXT, '
      '$roleColumnDescription TEXT, '
      '$roleColumnGroup INTEGER, '
      "$tableColumnCreatedDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnModifiedDate INTEGER DEFAULT (cast(strftime('%s','now') as int))"
      ')';

  @override
  Map<String, dynamic> toMap(Role object) => object.toMap();

  @override
  List<Role> fromList(List<Map<String, dynamic>> query) {
    List<Role> res = [];
    for (Map<String, dynamic> map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  Role fromMap(Map<String, dynamic> query) => Role.fromMap(query);
}

const roleTable = 'role';
const roleColumnId = 'id';
const roleColumnName = 'name';
const roleColumnDescription = 'description';
const roleColumnGroup = 'group';
