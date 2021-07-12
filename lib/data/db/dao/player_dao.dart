import 'package:mafia/data/db/dao/player_scope_dao.dart';
import 'package:mafia/data/model/player/player.dart';
import 'package:sqflite/sqflite.dart';

import '../database_provider.dart';
import 'dao.dart';

class PlayerDao implements BaseDao<Player> {
  final DatabaseProvider? databaseProvider;
  final PlayerScopeDao playerScopeDao;

  PlayerDao(this.databaseProvider, this.playerScopeDao);

  static String get createTableQuery => 'CREATE TABLE $playerTable ('
      '$playerColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$playerColumnName TEXT, '
      '$playerColumnScope INTEGER, '
      "$tableColumnCreatedDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnModifiedDate INTEGER DEFAULT (cast(strftime('%s','now') as int))"
      ')';

  @override
  Map<String, dynamic> toMap(Player object) => object.toMap();

  @override
  List<Player> fromList(List<Map<String, dynamic>> query) {
    List<Player> res = [];
    for (Map<String, dynamic> map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  Player fromMap(Map<String, dynamic> query) => Player.fromMap(query);

  @override
  Future<int> insert(Player data) async {
    final db = await databaseProvider!.db();
    return await db.insert(
      playerTable,
      toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future update(Player data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future delete(Player data) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<Player>?>? getAllFromDb() async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(
      playerTable,
      columns: [
        playerColumnId,
        playerColumnName,
        playerColumnScope,
        tableColumnCreatedDate,
        tableColumnModifiedDate,
      ],
    );
    if (map.length > 0) {
      return await Future.wait(fromList(map).map((element) async {
        return element.copyWith(
          scope: await playerScopeDao.getFromDb(element.scopeId),
        );
      }));
    }
    return null;
  }

  @override
  Future<Player?>? getFromDb(int id) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(playerTable,
        columns: [
          playerColumnId,
          playerColumnName,
          playerColumnScope,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$playerColumnId = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      final player = fromMap(map.first);
      return player.copyWith(
        scope: await playerScopeDao.getFromDb(id),
      );
    }
    return null;
  }

  @override
  Future<List<Player>?>? getAllFromDbByIds(List<int> ids) async {
    final StringBuffer whereList = StringBuffer("(");
    ids.forEach((id) {
      whereList.write("?, ");
    });
    final tmp = whereList.toString();
    final whereListString = tmp.replaceFirst(",", ")", tmp.length - 2);
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(playerTable,
        columns: [
          playerColumnId,
          playerColumnName,
          playerColumnScope,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$playerColumnId in $whereListString',
        whereArgs: ids);
    if (map.length > 0) {
      return await Future.wait(fromList(map).map((element) async {
        return element.copyWith(
          scope: await playerScopeDao.getFromDb(element.scopeId),
        );
      }));
    }
    return null;
  }
}

const playerTable = 'player';
const playerColumnId = 'id';
const playerColumnName = 'name';
const playerColumnScope = 'playerScope';
