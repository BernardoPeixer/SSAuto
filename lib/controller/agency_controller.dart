import 'package:ss_auto/model/agency_model.dart';
import 'package:ss_auto/model/manager_model.dart';

import '../database/database.dart';

class AgencyController {
  Future<List<Agency>> selectAgency() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result =
        await database.query(AgencyTable.tableName);

    var list = <Agency>[];
    for (final item in result) {
      list.add(
        Agency(
          agencyId: item[AgencyTable.agencyId],
          agencyName: item[AgencyTable.agencyName],
          agencyCity: item[AgencyTable.agencyCity],
          agencyState: item[AgencyTable.agencyState],
          managerCode: item[AgencyTable.managerCode],
        ),
      );
    }
    return list;
  }

  Future<Manager?> getManagerById(int managerId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.rawQuery('''
    SELECT m.* FROM ${ManagerTable.tableName} AS m 
    INNER JOIN ${AgencyTable.tableName} AS a ON a.managerCode = m.managerId 
    WHERE a.managerCode = ? 
    LIMIT 1 
    ''', [managerId]);

    return Manager(
      managerName: result.first[ManagerTable.managerId],
      managerCity: result.first[ManagerTable.managerCity],
      managerCpf: result.first[ManagerTable.managerCpf],
      managerState: result.first[ManagerTable.managerState],
      managerPhone: result.first[ManagerTable.managerPhone],
    );
  }

  Future<void> insert(Agency agency) async {
    final database = await getDatabase();
    final map = AgencyTable.toMap(agency);

    await database.insert(AgencyTable.tableName, map);

    return;
  }

  Future<void> delete(Agency agency) async {
    final database = await getDatabase();

    database.delete(
      AgencyTable.tableName,
      where: '${AgencyTable.agencyId} = ?',
      whereArgs: [agency.agencyId],
    );
  }
}
