import '../model/vehicle_model.dart';
import '../database/database.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VehicleController {
  Future<void> insert(Vehicle vehicle) async {
    final database = await getDatabase();
    final map = VehicleTable.toMap(vehicle);

    await database.insert(VehicleTable.tableName, map);

    return;
  }

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

  Future<String> updateVehicleStats(int vehicleId, String newStats) async{
    final database = await getDatabase();
    await database.update(
      VehicleTable.tableName,
      {VehicleTable.vehicleStats: newStats},
      where: '${VehicleTable.vehicleId} = ?',
      whereArgs: [vehicleId],
    );
    return newStats;
  }
}
