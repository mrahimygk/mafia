import 'package:mafia/data/model/role/role.dart';
import 'package:sqflite/sqflite.dart';

import '../database_provider.dart';
import 'dao.dart';

class RoleDao implements BaseDao<Role> {
  final DatabaseProvider? databaseProvider;

  RoleDao(this.databaseProvider);

  static String get createTableQuery => 'CREATE TABLE $roleTable ('
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

  @override
  Future<int> insert(Role data) async {
    final db = await databaseProvider!.db();
    return await db.insert(
      roleTable,
      toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future update(Role data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future delete(Role data) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Role>?>? getAllFromDb() async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(
      roleTable,
      columns: [
        roleColumnId,
        roleColumnName,
        roleColumnDescription,
        roleColumnGroup,
        tableColumnCreatedDate,
        tableColumnModifiedDate,
      ],
    );
    if (map.length > 0) {
      return fromList(map);
    }
    return null;
  }

  @override
  Future<Role?>? getFromDb(int id) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(roleTable,
        columns: [
          roleColumnId,
          roleColumnName,
          roleColumnDescription,
          roleColumnGroup,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$roleColumnId = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      return fromMap(map.first);
    }
    return null;
  }
}

const roleTable = 'role';
const roleColumnId = 'id';
const roleColumnName = 'name';
const roleColumnDescription = 'description';
const roleColumnGroup = 'group';
