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
          managerId: item[ManagerTable.managerId],
          managerName: item[ManagerTable.managerName],
          managerCpf: item[ManagerTable.managerCpf],
          managerPhone: item[ManagerTable.managerPhone],
          managerCity: item[ManagerTable.managerCity],
          managerState: item[ManagerTable.managerState],
          managerCommission: item[ManagerTable.managerCommission],
          managerEmail: item[ManagerTable.managerEmail],
        ),
      );
    }
    return list;
  }

  Future<Manager> updateManager(Manager newManager) async {
    final database = await getDatabase();
    final map = ManagerTable.toMap(newManager);

    await database.update(
      ManagerTable.tableName,
      map,
    );
    return newManager;
  }
}
