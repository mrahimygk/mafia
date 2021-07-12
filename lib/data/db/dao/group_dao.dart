import 'package:mafia/data/db/database_provider.dart';
import 'package:mafia/data/model/role/group.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class GroupDao implements BaseDao<Group> {
  final DatabaseProvider? databaseProvider;

  GroupDao(this.databaseProvider);

  static String get createTableQuery => 'CREATE TABLE $groupTable ('
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

  @override
  Future<int> insert(Group data) async {
    final db = await databaseProvider!.db();
    return await db.insert(
      groupTable,
      toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future update(Group data) async {
    final db = await databaseProvider!.db();
    await db.update(
      groupTable,
      toMap(data),
      where: '$groupColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future delete(Group data) async {
    final db = await databaseProvider!.db();
    await db.delete(
      groupTable,
      where: '$groupColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future<List<Group>?>? getAllFromDb() async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(
      groupTable,
      columns: [
        groupColumnId,
        groupColumnName,
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
  Future<Group?>? getFromDb(int id) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(groupTable,
        columns: [
          groupColumnId,
          groupColumnName,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$groupColumnId = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      return fromMap(map.first);
    }
    return null;
  }

  @override
  Future<List<Group>?>? getAllFromDbByIds(List<int> ids) {
    // TODO: implement getAllFromDbByIds
    throw UnimplementedError();
  }

  @override
  Future deleteByIds(List<int> ids) {
    // TODO: implement deleteByIds
    throw UnimplementedError();
  }
}

const groupTable = 'groupTable';
const groupColumnId = 'id';
const groupColumnName = 'name';
