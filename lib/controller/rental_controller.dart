import 'package:jiffy/jiffy.dart';
import 'package:sqflite/sqflite.dart';

import '../database/database.dart';
import '../model/chart_model.dart';
import '../model/rental_model.dart';
import '../model/vehicle_model.dart';

/// RENTAL CONTROLLER DATABASE
class RentalController {
  /// INSERT RENTAL IN DATABASE
  Future<void> insert(Rental vehicle) async {
    final database = await getDatabase();
    final map = RentalTable.toMap(vehicle);

    await database.insert(RentalTable.tableName, map);

    return;
  }

  /// SELECT FILTERED VEHICLES FROM DATABASE
  Future<List<Vehicle>> selectFilteredVehicles(int agencyId,
      String rentalStart,
      String rentalEnd,) async {
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

    final vehicles = result
        .map(
          (data) =>
          Vehicle(
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

  /// SELECT RENTALS FROM DATABASE
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

  /// UPDATE RENTAL STATS IN DATABASE
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

  /// SELECT THE LAST 6 MONTHS OF RENT
  Future<List<ChartModel>> rentalsMonth() async {
    final database = await getDatabase();

    final list = <ChartModel>[];
    for (var i = 0; i <= 5; i++) {
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

      final total = result[0]['total'] as double?;
      list.add(
        ChartModel(month: date, total: total, index: i),
      );
    }

    return list;
  }

  /// SELECT RENTAL STATS FROM DATABASE
  Future<List<String>> selectRentalStats() async {
    final database = await getDatabase();

    final list = <String>[];

    List<Map<String, dynamic>> result = await database.rawQuery('''
      SELECT rentalStats 
      FROM RentalTable
      ''');

    for (final item in result) {
      list.add(item['rentalStats']);
    }
    return list;
  }

  /// GET TOTAL RECORDS FROM DATABASE
  Future<int?> getTotalRecords() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.rawQuery('''
    SELECT COUNT(*) AS total_records
    FROM RentalTable
    ''');

    return Sqflite.firstIntValue(result);
  }

  /// GET RENTAL BY ID FROM DATABASE
  Future<Rental> getRentalById(int rentalId) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      RentalTable.tableName,
      where: '${RentalTable.rentalId} = ?',
      whereArgs: [rentalId],
    );
    return Rental(
      rentalId: result.first[RentalTable.rentalId],
        customerCode: result.first[RentalTable.customerCode],
        agencyCode: result.first[RentalTable.agencyCode],
        vehicleCode: result.first[RentalTable.vehicleCode],
        rentalRegisterDate: result.first[RentalTable.rentalRegisterDate],
        rentalStart: result.first[RentalTable.rentalStart],
        rentalEnd: result.first[RentalTable.rentalEnd],
        rentalCost: result.first[RentalTable.rentalCost],
        rentalStats: result.first[RentalTable.rentalStats],
        rentalPaymentStats: result.first[RentalTable.rentalPaymentStats]);
  }

}
