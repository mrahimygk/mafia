import 'package:mafia/data/db/dao/dao.dart';
import 'package:mafia/data/db/dao/prefs_data_dao.dart';

class PrefsData {
  final int uuid;
  final String? deviceId;
  final bool isFirstRun;
  final int installationDate;
  final int createdDate;
  final int modifiedDate;

  PrefsData(
    this.uuid,
    this.deviceId,
    this.isFirstRun,
    this.installationDate,
    this.createdDate,
    this.modifiedDate,
  );

  PrefsData copyWith({
   int? uuid,
   String? deviceId,
   bool? isFirstRun,
   int? installationDate,
   int? createdDate,
   int? modifiedDate,
  }) =>
      PrefsData(
        uuid ?? this.uuid,
        deviceId ?? this.deviceId,
        isFirstRun ?? this.isFirstRun,
        installationDate ?? this.installationDate,
        createdDate ?? this.createdDate,
        modifiedDate ?? this.modifiedDate,
      );

  Map<String, dynamic> toMap() {
    final data = Map<String, dynamic>();
    data[prefsDataColumnUuid] = uuid;
    data[prefsDataColumnDeviceId] = deviceId;
    data[prefsDataColumnIsFirstRun] = isFirstRun ? 1 : 0;
    data[prefsDataColumnInstallationDate] = installationDate;
    data[tableColumnCreatedDate] = createdDate;
    data[tableColumnModifiedDate] = modifiedDate;

    return data;
  }

  factory PrefsData.fromMap(Map<String, dynamic> json) => PrefsData(
        json[prefsDataColumnUuid],
        json[prefsDataColumnDeviceId],
        json[prefsDataColumnIsFirstRun] == 1,
        json[prefsDataColumnInstallationDate],
        json[tableColumnCreatedDate],
        json[tableColumnModifiedDate],
      );
}
