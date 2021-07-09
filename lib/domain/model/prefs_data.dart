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
}
