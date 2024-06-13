import '../model/manager_model.dart';
import '../database/database.dart';

class ManagerController {
  Future<void> insert(Manager manager) async {
    final database = await getDatabase();
    final map = ManagerTable.toMap(manager);

    await database.insert(ManagerTable.tableName, map);

    return;
  }

  Future<List<Manager>> selectManager() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result =
    await database.query(ManagerTable.tableName);

    var list = <Manager>[];
    for (final item in result) {
      list.add(
        Manager(
          id: item[ManagerTable.id],
          name: item[ManagerTable.name],
          cpf: item[ManagerTable.cpf],
          phone: item[ManagerTable.phone],
          city: item[ManagerTable.city],
          state: item[ManagerTable.state],
          email: item[ManagerTable.email],
        ),
      );
    }
    return list;
  }
}