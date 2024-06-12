import '../model/customer_model.dart';
import '../database/database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerController {
  Future<void> insert(Customer customer) async {
    final database = await getDatabase();
    final map = CustomerTable.toMap(customer);

    await database.insert(CustomerTable.tableName, map);

    return;
  }

  Future<List<Customer>> selectCustomers() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result =
        await database.query(CustomerTable.tableName);

    var list = <Customer>[];
    for (final item in result) {
      list.add(
        Customer(
          id: item[CustomerTable.id],
          company: item[CustomerTable.company],
          cnpj: item[CustomerTable.cnpj],
          phone: item[CustomerTable.phone],
          city: item[CustomerTable.city],
          state: item[CustomerTable.state],
          activity: item[CustomerTable.activity],
        ),
      );
    }
    return list;
  }
}
