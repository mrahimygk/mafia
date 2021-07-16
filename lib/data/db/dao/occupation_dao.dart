import 'package:mafia/data/db/dao/player_dao.dart';
import 'package:mafia/data/db/dao/role_dao.dart';
import 'package:mafia/data/db/database_provider.dart';
import 'package:mafia/data/model/player/occupation.dart';
import 'package:mafia/data/model/role/role.dart';
import 'package:sqflite/sqflite.dart';

import 'dao.dart';

class OccupationDao implements BaseDao<Occupation> {
  final DatabaseProvider? databaseProvider;
  final RoleDao roleDao;
  final PlayerDao playerDao;

  OccupationDao(
    this.databaseProvider,
    this.roleDao,
    this.playerDao,
  );

  static String get createTableQuery => 'CREATE TABLE $occupationTable ('
      '$occupationColumnId INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$occupationColumnGameId INTEGER, '
      '$occupationColumnPlayerId INTEGER, '
      '$occupationColumnRoleId INTEGER, '
      "$tableColumnCreatedDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnModifiedDate INTEGER DEFAULT (cast(strftime('%s','now') as int))"
      ')';

  @override
  Map<String, dynamic> toMap(Occupation object) => object.toMap();

  @override
  List<Occupation> fromList(List<Map<String, dynamic>> query) {
    List<Occupation> res = [];
    for (Map<String, dynamic> map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  Occupation fromMap(Map<String, dynamic> query) => Occupation.fromMap(query);

  @override
  Future<int> insert(Occupation data) async {
    final db = await databaseProvider!.db();
    return await db.insert(
      occupationTable,
      toMap(data),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future update(Occupation data) async {
    final db = await databaseProvider!.db();
    await db.update(
      occupationTable,
      toMap(data),
      where: '$occupationColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future delete(Occupation data) async {
    final db = await databaseProvider!.db();
    await db.delete(
      occupationTable,
      where: '$occupationColumnId = ?',
      whereArgs: [data.id],
    );
  }

  @override
  Future<List<Occupation>?>? getAllFromDb() async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(
      occupationTable,
      columns: [
        occupationColumnId,
        occupationColumnGameId,
        occupationColumnPlayerId,
        occupationColumnRoleId,
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
  Future<Occupation?>? getFromDb(int id) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(occupationTable,
        columns: [
          occupationColumnId,
          occupationColumnGameId,
          occupationColumnPlayerId,
          occupationColumnRoleId,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$occupationColumnId = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      return fromMap(map.first);
    }
    return null;
  }

  @override
  Future<List<Occupation>?>? getAllFromDbByIds(List<int> ids) {
    // TODO: implement getAllFromDbByIds
    throw UnimplementedError();
  }

  @override
  Future deleteByIds(List<int> ids) {
    // TODO: implement deleteByIds
    throw UnimplementedError();
  }

  Future<List<Role?>?>? getRolesForPlayer(int id) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(occupationTable,
        columns: [
          occupationColumnId,
          occupationColumnGameId,
          occupationColumnPlayerId,
          occupationColumnRoleId,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$occupationColumnId = ?',
        whereArgs: [id]);
    if (map.length > 0) {
      final List<Role?>? roles = [];
      final List<Occupation> occupations = fromList(map);
      occupations.forEach((element) {
        roleDao.getFromDb(element.roleId)?.then((value) => roles?.add(value));
      });

      return Future.value(roles);
    }
    return null;
  }

  Future<List<Occupation>?>? getOccupationsForGameId(int gameId) async {
    final db = await databaseProvider!.db();
    List<Map<String, dynamic>> map = await db.query(occupationTable,
        columns: [
          occupationColumnId,
          occupationColumnGameId,
          occupationColumnPlayerId,
          occupationColumnRoleId,
          tableColumnCreatedDate,
          tableColumnModifiedDate,
        ],
        where: '$occupationColumnGameId = ?',
        whereArgs: [gameId]);
    if (map.length > 0) {
      return await Future.wait(fromList(map).map((element) async {
        return element.copyWith(
          player: await playerDao.getFromDb(element.playerId),
          role: await roleDao.getFromDb(element.roleId),
        );
      }));
    }
    return null;
  }
}

const occupationTable = 'occupation';
const occupationColumnId = 'id';
const occupationColumnGameId = 'gameId';
const occupationColumnPlayerId = 'playerId';
const occupationColumnRoleId = 'roleId';
