import '../model/customerModel.dart';
import '../database/database.dart';

class CustomerController {
  Future<void> insert(Customer customer) async {
    final database = await getDatabase();
    final map = CustomerTable.toMap(customer);

    await database.insert(CustomerTable.tableName, map);

    return;
  }
}