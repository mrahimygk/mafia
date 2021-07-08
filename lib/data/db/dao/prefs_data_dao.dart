import 'package:mafia/data/model/role/prefs_data.dart';

import 'dao.dart';

class PrefsDataDao implements BaseDao<PrefsData> {
  @override
  String get createTableQuery => 'CREATE TABLE $prefsDataTable ('
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
}

const prefsDataTable = 'prefsData';
const prefsDataColumnUuid = 'uuid';
const prefsDataColumnDeviceId = 'deviceId';
const prefsDataColumnInstallationDate = 'installationDate';
const prefsDataColumnIsFirstRun = 'isFirstRun';
