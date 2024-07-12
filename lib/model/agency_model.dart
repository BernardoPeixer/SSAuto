import 'package:ss_auto/model/manager_model.dart';

class Agency {
  Agency({
    this.agencyId,
    required this.agencyName,
    required this.agencyState,
    required this.agencyCity,
    required this.agencyPhone,
    required this.agencyAddress,
    this.managerCode,
  });

  late int? agencyId;
  final String agencyName;
  final String agencyState;
  final String agencyCity;
  final String agencyPhone;
  final String agencyAddress;
  int? managerCode;
}

class AgencyTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $agencyId     INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $managerCode  INTEGER NOT NULL,
      $agencyName   TEXT NOT NULL,
      $agencyState  TEXT NOT NULL,
      $agencyCity   TEXT NOT NULL,
      $agencyPhone  TEXT NOT NULL,
      $agencyAddress  TEXT NOT NULL,
      FOREIGN KEY($managerCode) REFERENCES ${ManagerTable.tableName}(${ManagerTable.managerId})
    );
    ''';

  static const String tableName = 'AgencyTable';
  static const String agencyId = 'agencyId';
  static const String agencyName = 'agencyName';
  static const String agencyState = 'agencyState';
  static const String agencyCity = 'agencyCity';
  static const String agencyPhone = 'agencyPhone';
  static const String agencyAddress = 'agencyAddress';
  static const String managerCode = 'managerCode';

  static Map<String, dynamic> toMap(Agency agency) {
    final map = <String, dynamic>{};

    map[AgencyTable.agencyName] = agency.agencyName;
    map[AgencyTable.agencyState] = agency.agencyState;
    map[AgencyTable.agencyCity] = agency.agencyCity;
    map[AgencyTable.managerCode] = agency.managerCode;
    map[AgencyTable.agencyPhone] = agency.agencyPhone;
    map[AgencyTable.agencyAddress] = agency.agencyAddress;
    return map;
  }
}
