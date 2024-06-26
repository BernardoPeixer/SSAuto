class Agency {
  Agency({
    this.agencyId,
    required this.agencyName,
    required this.agencyState,
    required this.agencyCity,
  });

  late int? agencyId;
  final String agencyName;
  final String agencyState;
  final String agencyCity;
}

class AgencyTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $agencyId     INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $agencyName   TEXT NOT NULL,
      $agencyState  TEXT NOT NULL,
      $agencyCity   TEXT NOT NULL
    );
    ''';

  static const String tableName = 'AgencyTable';
  static const String agencyId = 'agencyId';
  static const String agencyName = 'agencyName';
  static const String agencyState = 'agencyState';
  static const String agencyCity = 'agencyCity';

  static Map<String, dynamic> toMap(Agency agency) {
    final map = <String, dynamic>{};

    map[AgencyTable.agencyName] = agency.agencyName;
    map[AgencyTable.agencyState] = agency.agencyState;
    map[AgencyTable.agencyCity] = agency.agencyCity;
    return map;
  }
}
