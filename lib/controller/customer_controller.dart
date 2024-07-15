import 'package:sqflite/sqflite.dart';

import '../database/database.dart';
import '../model/customer_model.dart';

/// AGENCY CONTROLLER DATABASE
class CustomerController {
  /// FUNCTION TO INSERT CUSTOMER IN DATABASE
  Future<void> insert(Customer customer) async {
    final database = await getDatabase();
    final map = CustomerTable.toMap(customer);

    await database.insert(CustomerTable.tableName, map);

    return;
  }

  /// FUNCTION TO GET CUSTOMERS ID BY NAME
  Future<int?> getCustomerIdByName(String customerName) async {
    final database = await getDatabase();

    List<Map<String, dynamic>> result = await database.rawQuery(
      '''SELECT ${CustomerTable.customerId} 
      FROM ${CustomerTable.tableName} 
      WHERE ${CustomerTable.customerName} = ?
      ''',
      [customerName],
    );

    if (result.isNotEmpty) {
      return result.first['customerId'] as int;
    } else {
      return null;
    }
  }

  /// FUNCTION TO SELECT CUSTOMERS FROM DATABASE
  Future<List<Customer>> selectCustomers() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result =
        await database.query(CustomerTable.tableName);

    var list = <Customer>[];
    for (final item in result) {
      list.add(
        Customer(
          customerId: item[CustomerTable.customerId],
          customerName: item[CustomerTable.customerName],
          customerCnpj: item[CustomerTable.customerCnpj],
          customerPhone: item[CustomerTable.customerPhone],
          customerCity: item[CustomerTable.customerCity],
          customerState: item[CustomerTable.customerState],
          customerStats: item[CustomerTable.customerStats],
        ),
      );
    }
    return list;
  }

  /// FUNCTION TO DELETE CUSTOMER FROM DATABASE
  Future<void> delete(Customer customer) async {
    final database = await getDatabase();

    database.delete(
      CustomerTable.tableName,
      where: '${CustomerTable.customerId} = ?',
      whereArgs: [customer.customerId],
    );
  }

  /// FUNCTION TO COUNT TOTAL RECORDS IN DATABASE
  Future<int?> getTotalRecords() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.rawQuery('''
    SELECT COUNT(*) AS total_records
    FROM CustomerTable
    ''');

    return Sqflite.firstIntValue(result);
  }
}
