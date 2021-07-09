import 'package:mafia/data/db/database_provider.dart';
import 'package:mafia/data/model/player/player_scope.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class PlayerScopeDao implements BaseDao<PlayerScope> {
  final DatabaseProvider? databaseProvider;

  PlayerScopeDao(this.databaseProvider);

  static String get createTableQuery => 'CREATE TABLE $playerScopeTable ('
      '$playerScopeColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$playerScopeColumnName TEXT, '
      "$tableColumnCreatedDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnModifiedDate INTEGER DEFAULT (cast(strftime('%s','now') as int))"
      ')';

  @override
  Map<String, dynamic> toMap(PlayerScope object) => object.toMap();

  @override
  List<PlayerScope> fromList(List<Map<String, dynamic>> query) {
    List<PlayerScope> res = [];
    for (Map<String, dynamic> map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  PlayerScope fromMap(Map<String, dynamic> query) => PlayerScope.fromMap(query);

  @override
  Future<int> insert(PlayerScope data) async {
    final db = await databaseProvider!.db();
    return await db.insert(
      playerScopeTable,
      toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future update(PlayerScope data) async {
    final db = await databaseProvider!.db();
    await db.update(
      playerScopeTable,
      toMap(data),
      where: '$playerScopeColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future delete(PlayerScope data) async {
    final db = await databaseProvider!.db();
    await db.delete(
      playerScopeTable,
      where: '$playerScopeColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future<List<PlayerScope>?>? getAllFromDb() async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(
      playerScopeTable,
      columns: [
        playerScopeColumnId,
        playerScopeColumnName,
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
  Future<PlayerScope?>? getFromDb(int id) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(playerScopeTable,
        columns: [
          playerScopeColumnId,
          playerScopeColumnName,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$playerScopeColumnId = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      return fromMap(map.first);
    }
    return null;
  }
}

const playerScopeTable = 'playerScope';
const playerScopeColumnId = 'id';
const playerScopeColumnName = 'name';
