class Customer {
  Customer({
    required this.customerName,
    required this.customerCity,
    required this.customerCnpj,
    required this.customerState,
    required this.customerPhone,
    required this.customerStats,
    this.customerId,
  });


  final String customerName;
  final String customerCity;
  final String customerCnpj;
  final String customerState;
  final String customerPhone;
  final String customerStats;
  late int? customerId;
}

class CustomerTable {
  static const String createTable = '''
    CREATE TABLE $tableName(
      $customerId         INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      $customerName       TEXT NOT NULL,
      $customerCity       TEXT NOT NULL,
      $customerState      TEXT NOT NULL,
      $customerCnpj       TEXT NOT NULL,
      $customerPhone      TEXT NOT NULL,
      $customerStats      TEXT NOT NULL
    );
    ''';

  static const String tableName = 'CustomerTable';
  static const String customerId = 'customerId';
  static const String customerName = 'customerName';
  static const String customerCity = 'customerCity';
  static const String customerCnpj = 'customerCnpj';
  static const String customerState = 'customerState';
  static const String customerPhone = 'customerPhone';
  static const String customerStats = 'customerStats';

  static Map<String, dynamic> toMap(Customer customer) {
    final map = <String, dynamic>{};

    map[CustomerTable.customerName] = customer.customerName;
    map[CustomerTable.customerCity] = customer.customerCity;
    map[CustomerTable.customerCnpj] = customer.customerCnpj;
    map[CustomerTable.customerState] = customer.customerState;
    map[CustomerTable.customerPhone] = customer.customerPhone;
    map[CustomerTable.customerStats] = customer.customerStats;

    return map;
  }


}
