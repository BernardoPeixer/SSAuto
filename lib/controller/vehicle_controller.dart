import 'package:sqflite/sqflite.dart';

import '../database/database.dart';
import '../model/vehicle_model.dart';

/// VEHICLE CONTROLLER DATABASE
class VehicleController {

  /// INSERT VEHICLE IN DATABASE
  Future<void> insert(Vehicle vehicle) async {
    final database = await getDatabase();
    final map = VehicleTable.toMap(vehicle);

    await database.insert(VehicleTable.tableName, map);

    return;
  }

  /// SELECT VEHICLES FROM DATABASE
  Future<List<Vehicle>> selectVehicles() async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result =
        await database.query(VehicleTable.tableName);
    var list = <Vehicle>[];

    for (final item in result) {
      list.add(
        Vehicle(
          vehicleBrand: item[VehicleTable.vehicleBrand],
          vehicleModel: item[VehicleTable.vehicleModel],
          vehicleLicensePlate: item[VehicleTable.vehicleLicensePlate],
          vehicleYear: item[VehicleTable.vehicleYear],
          vehicleDailyCost: item[VehicleTable.vehicleDailyCost],
          vehicleId: item[VehicleTable.vehicleId],
          agencyCode: item[VehicleTable.agencyCode],
          vehicleStats: item[VehicleTable.vehicleStats],
        ),
      );
    }
    return list;
  }

  /// UPDATE VEHICLE STATS IN DATABASE
  Future<String> updateVehicleStats(int vehicleId, String newStats) async {
    final database = await getDatabase();
    await database.update(
      VehicleTable.tableName,
      {VehicleTable.vehicleStats: newStats},
      where: '${VehicleTable.vehicleId} = ?',
      whereArgs: [vehicleId],
    );
    return newStats;
  }

  /// GET TOTAL RECORDS FROM DATABASE
  Future<int?> getTotalRecords() async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.rawQuery('''
    SELECT COUNT(*) AS total_records
    FROM VehicleTable
    ''');

    return Sqflite.firstIntValue(result);
  }

  /// GET VEHICLE BY ID FROM DATABASE
  Future<Vehicle> getVehicleById(int vehicleId) async {
    final database = await getDatabase();
    final List<Map<String, dynamic>> result = await database.query(
      VehicleTable.tableName,
      where: '${VehicleTable.vehicleId} = ?',
      whereArgs: [vehicleId],
    );
      return Vehicle(
        vehicleBrand: result.first[VehicleTable.vehicleBrand],
        vehicleModel: result.first[VehicleTable.vehicleModel],
        vehicleLicensePlate: result.first[VehicleTable.vehicleLicensePlate],
        vehicleYear: result.first[VehicleTable.vehicleYear],
        vehicleDailyCost: result.first[VehicleTable.vehicleDailyCost],
        vehicleStats: result.first[VehicleTable.vehicleStats],
        agencyCode: result.first[VehicleTable.agencyCode],
        vehicleId: result.first[VehicleTable.vehicleId],
      );
  }
}
