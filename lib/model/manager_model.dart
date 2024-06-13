class Manager {
  Manager({
    required this.name,
    required this.city,
    required this.cpf,
    required this.state,
    required this.email,
    required this.phone,
    this.id,
  });

  final String name;
  final String city;
  final String cpf;
  final String state;
  final String email;
  final String phone;
  late int? id;
}

class ManagerTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id     INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $name   TEXT NOT NULL,
      $city   TEXT NOT NULL,
      $cpf    TEXT NOT NULL,
      $state  TEXT NOT NULL,
      $email  TEXT NOT NULL,
      $phone  TEXT NOT NULL
    );
    ''';

  static const String tableName = 'manager';
  static const String id = 'id';
  static const String name = 'name';
  static const String city = 'city';
  static const String cpf = 'cpf';
  static const String state = 'state';
  static const String email = 'email';
  static const String phone = 'phone';

  static Map<String, dynamic> toMap(Manager manager) {
    final map = <String, dynamic>{};

    map[ManagerTable.name] = manager.name;
    map[ManagerTable.city] = manager.city;
    map[ManagerTable.cpf] = manager.cpf;
    map[ManagerTable.state] = manager.state;
    map[ManagerTable.email] = manager.email;
    map[ManagerTable.phone] = manager.phone;

    return map;
  }
}
