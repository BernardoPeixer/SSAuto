import 'package:sqflite/sqflite.dart';

import '../database/database.dart';
import '../model/agency_model.dart';
import '../model/manager_model.dart';

/// AGENCY CONTROLLER DATABASE
class AgencyController {
  /// FUNCTION TO SELECT AGENCY FROM DATABASE
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
          agencyPhone: item[AgencyTable.agencyPhone],
          agencyAddress: item[AgencyTable.agencyAddress],
        ),
      );
    }
    return list;
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

  /// FUNCTION TO INSERT AGENCY IN DATABASE
  Future<void> insert(Agency agency) async {
    final database = await getDatabase();
    final map = AgencyTable.toMap(agency);

    await database.insert(AgencyTable.tableName, map);

    return;
  }

  /// FUNCTION TO DELETE AGENCY IN DATABASE
  Future<void> delete(Agency agency) async {
    final database = await getDatabase();

    database.delete(
      AgencyTable.tableName,
      where: '${AgencyTable.agencyId} = ?',
      whereArgs: [agency.agencyId],
    );
  }

  /// FUNCTION TO GET TOTAL RECORDS IN DATABASE
  Future<int?> getTotalRecords() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.rawQuery('''
    SELECT COUNT(*) AS total_records
    FROM AgencyTable
    ''');

    return Sqflite.firstIntValue(result);
  }

  /// GET AGENCY BY ID FROM DATABASE
  Future<Agency?> getAgencyById(int agencyId) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      AgencyTable.tableName,
      where: '${AgencyTable.agencyId} = ?',
      whereArgs: [agencyId],
    );

    if (result.isNotEmpty) {
      return Agency(
        agencyName: result.first[AgencyTable.agencyName],
        agencyState: result.first[AgencyTable.agencyState],
        agencyCity: result.first[AgencyTable.agencyCity],
        agencyPhone: result.first[AgencyTable.agencyPhone],
        agencyAddress: result.first[AgencyTable.agencyAddress],
        agencyId: result.first[AgencyTable.agencyId],
        managerCode: result.first[AgencyTable.managerCode],
      );
    }
    return null;
  }

  /// FUNCTION TO UPDATE AGENCY FROM DATABASE
  Future<Agency> updateAgency(Agency agency) async {
    final database = await getDatabase();
    final map = AgencyTable.toMap(agency);

    await database.update(
      AgencyTable.tableName,
      map,
      where: '${AgencyTable.agencyId} = ?',
      whereArgs: [agency.agencyId],
    );
    return agency;
  }
}
