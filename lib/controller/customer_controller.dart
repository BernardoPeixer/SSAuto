import '../model/customer_model.dart';
import '../database/database.dart';

class CustomerController {
  Future<void> insert(Customer customer) async {
    final database = await getDatabase();
    final map = CustomerTable.toMap(customer);

    await database.insert(CustomerTable.tableName, map);

    return;
  }

  Future<int?> getCustomerIdByName(String customerName) async {
    final database = await getDatabase();

    List<Map<String, dynamic>> result = await database.rawQuery(
      'SELECT ${CustomerTable.customerId} FROM ${CustomerTable.tableName} WHERE ${CustomerTable.customerName} = ?',
      [customerName],
    );

    if (result.isNotEmpty) {
      return result.first['customerId'] as int;
    } else {
      return null;
    }
  }

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
}
