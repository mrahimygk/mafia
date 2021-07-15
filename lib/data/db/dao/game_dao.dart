import 'package:mafia/data/db/dao/occupation_dao.dart';
import 'package:mafia/data/db/database_provider.dart';
import 'package:mafia/data/model/game/game.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class GameDao implements BaseDao<Game> {
  final DatabaseProvider? databaseProvider;
  final OccupationDao occupationDao;

  GameDao(this.databaseProvider, this.occupationDao);

  static String get createTableQuery => 'CREATE TABLE $gameTable ('
      '$gameColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      "$tableColumnCreatedDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnModifiedDate INTEGER DEFAULT (cast(strftime('%s','now') as int))"
      ')';

  @override
  Map<String, dynamic> toMap(Game object) => object.toMap();

  @override
  List<Game> fromList(List<Map<String, dynamic>> query) {
    List<Game> res = [];
    for (Map<String, dynamic> map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  Game fromMap(Map<String, dynamic> query) => Game.fromMap(query);

  @override
  Future<int> insert(Game data) async {
    final db = await databaseProvider!.db();
    return await db.insert(
      gameTable,
      toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future update(Game data) async {
    final db = await databaseProvider!.db();
    await db.update(
      gameTable,
      toMap(data),
      where: '$gameColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future delete(Game data) async {
    final db = await databaseProvider!.db();
    await db.delete(
      gameTable,
      where: '$gameColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future<List<Game>?>? getAllFromDb() async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(
      gameTable,
      columns: [
        gameColumnId,
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
  Future<Game?>? getFromDb(int id) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(gameTable,
        columns: [
          gameColumnId,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$gameColumnId = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      return fromMap(map.first);
    }
    return null;
  }

  @override
  Future<List<Game>?>? getAllFromDbByIds(List<int> ids) {
    // TODO: implement getAllFromDbByIds
    throw UnimplementedError();
  }

  @override
  Future deleteByIds(List<int> ids) {
    // TODO: implement deleteByIds
    throw UnimplementedError();
  }
}

const gameTable = 'gameTable';
const gameColumnId = 'id';
