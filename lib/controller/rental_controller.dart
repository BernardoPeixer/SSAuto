import 'package:jiffy/jiffy.dart';
import 'package:pdf/widgets.dart';
import 'package:ss_auto/model/agency_model.dart';
import 'package:ss_auto/model/rental_model.dart';
import '../database/database.dart';
import '../model/chart_model.dart';
import '../model/vehicle_model.dart';

class RentalController {
  Future<void> insert(Rental vehicle) async {
    final database = await getDatabase();
    final map = RentalTable.toMap(vehicle);

    await database.insert(RentalTable.tableName, map);

    return;
  }

  Future<List<Vehicle>> selectFilteredVehicles(
    int agencyId,
    String rentalStart,
    String rentalEnd,
  ) async {
    final database = await getDatabase();

    List<Map<String, dynamic>> result = await database.rawQuery('''
  SELECT DISTINCT v.* 
  FROM ${VehicleTable.tableName} AS v 
  LEFT JOIN ${RentalTable.tableName} AS r 
  ON v.${VehicleTable.vehicleId} = r.${RentalTable.vehicleCode} 
  AND NOT (
    r.${RentalTable.rentalStart} >= ? OR r.rentalEnd <= ? 
  ) 
  WHERE v.${VehicleTable.agencyCode} = ? 
    AND (
      r.${RentalTable.vehicleCode} IS NULL 
      OR r.${RentalTable.rentalStart} IS NULL 
      OR r.${RentalTable.rentalEnd} IS NULL
    )
    AND v.${VehicleTable.vehicleStats} = 'Disponivel';
  ''', [
      rentalEnd,
      rentalStart,
      agencyId,
    ]);

    List<Vehicle> vehicles = result
        .map(
          (data) => Vehicle(
            vehicleBrand: data['vehicleBrand'],
            vehicleModel: data['vehicleModel'],
            vehicleLicensePlate: data['vehicleLicensePlate'],
            vehicleYear: data['vehicleYear'],
            vehicleDailyCost: data['vehicleDailyCost'],
            vehicleId: data['vehicleId'],
            agencyCode: data['agencyCode'],
            vehicleStats: data['vehicleStats'],
          ),
        )
        .toList();

    return vehicles;
  }

  Future<List<Rental>> selectRentals() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result =
        await database.query(RentalTable.tableName);

    var list = <Rental>[];
    for (final item in result) {
      list.add(
        Rental(
          rentalId: item[RentalTable.rentalId],
          rentalCost: item[RentalTable.rentalCost],
          rentalStart: item[RentalTable.rentalStart],
          rentalEnd: item[RentalTable.rentalEnd],
          rentalRegisterDate: item[RentalTable.rentalRegisterDate],
          rentalStats: item[RentalTable.rentalStats],
          rentalPaymentStats: item[RentalTable.rentalPaymentStats],
          vehicleCode: item[RentalTable.vehicleCode],
          agencyCode: item[RentalTable.agencyCode],
          customerCode: item[RentalTable.customerCode],
        ),
      );
    }
    return list;
  }

  Future<String> updateRentalStats(int rentalId, String newStats) async {
    final database = await getDatabase();
    await database.update(
      RentalTable.tableName,
      {RentalTable.rentalStats: newStats},
      where: '${RentalTable.rentalId} = ?',
      whereArgs: [rentalId],
    );
    return newStats;
  }

  Future<List<ChartModel>> teste() async {
    final database = await getDatabase();

    final list = <ChartModel>[];
    for (int i = 0; i <= 5; i++) {
      final date = Jiffy.now().subtract(months: i).format(pattern: 'yyyy-MM');

      List<Map<String, dynamic>> result = await database.rawQuery(
        '''
    SELECT SUM(rentalCost) as total
    FROM RentalTable 
    WHERE STRFTIME('%Y-%m', rentalRegisterDate) 
    = ? 
    ''',
        [date],
      );

      double? total = result[0]['total'] as double?;
      list.add(
        ChartModel(month: date, total: total, index: i),
      );
    }


    // for(final item in list) {
    //   print('${item.month} / ${item.total}');
    // }
    return list;
  }
}
