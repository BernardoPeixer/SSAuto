import 'package:ss_auto/model/agency_model.dart';
import 'package:ss_auto/model/rental_model.dart';
import '../database/database.dart';
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
}
