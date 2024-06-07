import '../model/manager_model.dart';
import '../database/database.dart';

class ManagerController {
  Future<void> insert(Manager manager) async {
    final database = await getDatabase();
    final map = ManagerTable.toMap(manager);

    await database.insert(ManagerTable.tableName, map);

    return;
  }
}