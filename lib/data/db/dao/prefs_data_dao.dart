import 'package:mafia/data/model/role/prefs_data.dart';

import '../database_provider.dart';
import 'dao.dart';

class PrefsDataDao implements BaseDao<PrefsData> {
  final DatabaseProvider? databaseProvider;

  PrefsDataDao(this.databaseProvider);

  static String get createTableQuery => 'CREATE TABLE $prefsDataTable ('
      '$prefsDataColumnUuid INTEGER PRIMARY KEY AUTOINCREMENT, '
      '$prefsDataColumnDeviceId TEXT, '
      '$prefsDataColumnIsFirstRun INTEGER, '
      "$prefsDataColumnInstallationDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnCreatedDate INTEGER DEFAULT (cast(strftime('%s','now') as int)), "
      "$tableColumnModifiedDate INTEGER DEFAULT (cast(strftime('%s','now') as int))"
      ')';

  @override
  Map<String, dynamic> toMap(PrefsData object) => object.toMap();

  @override
  List<PrefsData> fromList(List<Map<String, dynamic>> query) {
    List<PrefsData> res = [];
    for (Map<String, dynamic> map in query) {
      res.add(fromMap(map));
    }

    return res;
  }

  @override
  PrefsData fromMap(Map<String, dynamic> query) => PrefsData.fromMap(query);

  @override
  Future<int> insert(PrefsData data) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future update(PrefsData data) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future delete(PrefsData data) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<PrefsData>?>? getAllFromDb() {
    // TODO: implement getAllFromDb
    throw UnimplementedError();
  }

  @override
  Future<PrefsData?>? getFromDb(int id) {
    // TODO: implement getFromDb
    throw UnimplementedError();
  }

  @override
  Future<List<PrefsData>?>? getAllFromDbByIds(List<int> ids) {
    // TODO: implement getAllFromDbByIds
    throw UnimplementedError();
  }

  @override
  Future deleteByIds(List<int> ids) {
    // TODO: implement deleteByIds
    throw UnimplementedError();
  }
}

const prefsDataTable = 'prefsData';
const prefsDataColumnUuid = 'uuid';
const prefsDataColumnDeviceId = 'deviceId';
const prefsDataColumnInstallationDate = 'installationDate';
const prefsDataColumnIsFirstRun = 'isFirstRun';
