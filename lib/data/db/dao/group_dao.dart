import 'package:mafia/data/model/role/group.dart';

import 'dao.dart';

class GroupDao implements BaseDao<Group> {
  @override
  String get createTableQuery => 'CREATE TABLE $groupTable ('
      '$groupColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$groupColumnName TEXT, '
      "$tableColumnCreatedDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnModifiedDate INTEGER DEFAULT (cast(strftime('%s','now') as int))"
      ')';

  @override
  Map<String, dynamic> toMap(Group object) => object.toMap();

  @override
  List<Group> fromList(List<Map<String, dynamic>> query) {
    List<Group> res = [];
    for (Map<String, dynamic> map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  Group fromMap(Map<String, dynamic> query) => Group.fromMap(query);
}

const groupTable = 'group';
const groupColumnId = 'id';
const groupColumnName = 'name';
