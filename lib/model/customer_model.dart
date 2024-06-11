class Customer {
  Customer({
    required this.company,
    required this.city,
    required this.cnpj,
    required this.state,
    required this.phone,
    required this.activity,
    this.id,
  });


  final String company;
  final String city;
  final String cnpj;
  final String state;
  final String phone;
  final String activity;
  late int? id;
}

class CustomerTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $id            INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $company       TEXT NOT NULL,
      $city          TEXT NOT NULL,
      $cnpj          TEXT NOT NULL,
      $state         TEXT NOT NULL,
      $phone         TEXT NOT NULL,
      $activity      TEXT NOT NULL
    );
    ''';

  static const String tableName = 'customer';
  static const String id = 'id';
  static const String company = 'company';
  static const String city = 'city';
  static const String cnpj = 'cnpj';
  static const String state = 'state';
  static const String phone = 'phone';
  static const String activity = 'activity';

  static Map<String, dynamic> toMap(Customer customer) {
    final map = <String, dynamic>{};

    map[CustomerTable.company] = customer.company;
    map[CustomerTable.city] = customer.city;
    map[CustomerTable.cnpj] = customer.cnpj;
    map[CustomerTable.state] = customer.state;
    map[CustomerTable.phone] = customer.phone;
    map[CustomerTable.activity] = customer.activity;

    return map;
  }


}
