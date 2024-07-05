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

  Future<List<Vehicle>> selectCars(int agencyId) async {
    final database = await getDatabase();

    final List<Map<String, dynamic>> result = await database.query(
      VehicleTable.tableName,
      where: '${VehicleTable.agencyCode} = ?',
      whereArgs: [agencyId],
    );

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
