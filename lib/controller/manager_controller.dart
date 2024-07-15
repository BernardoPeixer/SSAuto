import '../database/database.dart';
import '../model/manager_model.dart';

/// MANAGER CONTROLLER DATABASE
class ManagerController {
  /// FUNCTION TO INSERT MANAGER IN DATABASE
  Future<void> insert(Manager manager) async {
    final database = await getDatabase();
    final map = ManagerTable.toMap(manager);

    await database.insert(ManagerTable.tableName, map);

    return;
  }

  /// FUNCTION TO SELECT MANAGER FROM DATABASE
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

  /// FUNCTION TO UPDATE MANAGER IN DATABASE
  Future<Manager> updateManager(Manager newManager) async {
    final database = await getDatabase();
    final map = ManagerTable.toMap(newManager);

    await database.update(
      ManagerTable.tableName,
      map,
      where: '${ManagerTable.managerId} = ?',
      whereArgs: [newManager.managerId],
    );
    return newManager;
  }

  /// FUNCTION TO GET MANAGER BY ID FROM DATABASE
  Future<Manager?> getManagerById(int managerId) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      ManagerTable.tableName,
      where: '${ManagerTable.managerId} = ?',
      whereArgs: [managerId],
    );

    if (result.isNotEmpty) {
      return Manager(
        managerId: result.first[ManagerTable.managerId],
        managerName: result.first[ManagerTable.managerName],
        managerCpf: result.first[ManagerTable.managerCpf],
        managerPhone: result.first[ManagerTable.managerPhone],
        managerCity: result.first[ManagerTable.managerCity],
        managerState: result.first[ManagerTable.managerState],
        managerCommission: result.first[ManagerTable.managerCommission],
        managerEmail: result.first[ManagerTable.managerEmail],
      );
    }
    return null;
  }

  /// FUNCTION TO DELETE MANAGER IN DATABASE
  Future<void> delete(Manager manager) async {
    final database = await getDatabase();

    database.delete(
      ManagerTable.tableName,
      where: '${ManagerTable.managerId} = ?',
      whereArgs: [manager.managerId],
    );
  }
}
