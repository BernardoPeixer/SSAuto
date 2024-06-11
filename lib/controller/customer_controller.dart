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

  Future<void> getBrasilApi() async {
    final cnpjRequest = await http.get(
      Uri.parse('https://brasilapi.com.br/api/cnpj/v1/36127778000103'),
      headers: {},
    );

    print(cnpjRequest.body);
  }


}
