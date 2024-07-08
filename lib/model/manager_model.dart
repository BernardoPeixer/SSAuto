
class Manager {
  Manager({
    required this.managerName,
    required this.managerCity,
    required this.managerCpf,
    required this.managerState,
    required this.managerPhone,
    this.managerId,
  });

  final String managerName;
  final String managerCity;
  final String managerCpf;
  final String managerState;
  final String managerPhone;
  late int? managerId;
}

class ManagerTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $managerId     INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $managerName   TEXT NOT NULL,
      $managerCity   TEXT NOT NULL,
      $managerCpf    TEXT NOT NULL,
      $managerState  TEXT NOT NULL,
      $managerPhone  TEXT NOT NULL
    );
    ''';

  static const String tableName = 'ManagerTable';
  static const String managerId = 'managerId';
  static const String managerName = 'managerName';
  static const String managerCity = 'managerCity';
  static const String managerCpf = 'managerCpf';
  static const String managerState = 'managerState';
  static const String managerPhone = 'managerPhone';

  static Map<String, dynamic> toMap(Manager manager) {
    final map = <String, dynamic>{};

    map[ManagerTable.managerName] = manager.managerName;
    map[ManagerTable.managerCity] = manager.managerCity;
    map[ManagerTable.managerCpf] = manager.managerCpf;
    map[ManagerTable.managerState] = manager.managerState;
    map[ManagerTable.managerPhone] = manager.managerPhone;
    return map;
  }
}
