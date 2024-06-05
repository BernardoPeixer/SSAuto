import '../model/vehicleModel.dart';
import '../database/database.dart';

class VehicleController {
  Future<void> insert(Vehicle vehicle) async {
    final database = await getDatabase();
    final map = VehicleTable.toMap(vehicle);

    await database.insert(VehicleTable.tableName, map);

    return;
  }
}
