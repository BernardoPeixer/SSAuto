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
    SELECT v.* FROM ${VehicleTable.tableName} AS v 
    LEFT JOIN ${RentalTable.tableName} AS r 
    ON v.${VehicleTable.vehicleId} = r.${RentalTable.vehicleCode} 
    AND (
    r.${RentalTable.rentalStart} IS NULL OR 
    (r.${RentalTable.rentalStart} NOT BETWEEN '$rentalStart' AND '$rentalEnd' 
    AND r.${RentalTable.rentalEnd} NOT BETWEEN '$rentalStart' AND '$rentalEnd')
    )
    WHERE 
    v.${VehicleTable.agencyCode} = $agencyId
    ''');

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
          ),
        )
        .toList();

    return vehicles;
  }
}
