import '../model/vehicle_model.dart';
import '../database/database.dart';

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
          brand: item[VehicleTable.brand],
          model: item[VehicleTable.model],
          licensePlate: item[VehicleTable.licensePlate],
          year: item[VehicleTable.year],
          category: item[VehicleTable.category],
          dailyCost: item[VehicleTable.dailyCost],
          mileage: item[VehicleTable.mileage],
          color: item[VehicleTable.color],
          air: item[VehicleTable.air],
          sensor: item[VehicleTable.sensor],
        ),
      );
    }
    return list;
  }
}
