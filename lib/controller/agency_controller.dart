import 'package:ss_auto/model/agency_model.dart';

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
        ),
      );
    }
    return list;
  }

  Future<void> insert(Agency agency) async {
    final database = await getDatabase();
    final map = AgencyTable.toMap(agency);

    await database.insert(AgencyTable.tableName, map);

    return;
  }
}