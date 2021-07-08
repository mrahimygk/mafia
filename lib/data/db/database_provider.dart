import 'dart:math';

import 'package:mafia/common/data/group_list.dart';
import 'package:mafia/common/data/prefs_data.dart';
import 'package:mafia/common/data/role_list.dart';
import 'package:mafia/data/db/dao/group_dao.dart';
import 'package:mafia/data/db/dao/role_dao.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'dao/prefs_data_dao.dart';

class DatabaseProvider {
  static final _instance = DatabaseProvider._internal();
  static DatabaseProvider get = _instance;
  bool isInit = false;
  Database? _db;

  DatabaseProvider._internal();

  Future<Database> db() async {
    if (!isInit) await _init();
    return _db!;
  }

  Future _init() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, 'app.db');

    _db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(RoleDao().createTableQuery);

      final deviceId = Random.secure().nextDouble() * (double.maxFinite / 10);
      final batch = db.batch();

      batch.insert(prefsDataTable,
          prefsData.copyWith(deviceId: deviceId.toString()).toMap());

      groupList.forEach((element) {
        batch.insert(groupTable, element.toMap());
      });

      roleList.forEach((element) {
        batch.insert(roleTable, element.toMap());
      });

      batch.commit();
    });
    isInit = true;
  }
}
