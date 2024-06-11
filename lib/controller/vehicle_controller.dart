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

  // Future<void> getApi() async {
  //   final modelsBrandsRespondes = await http.get(
  //     Uri.parse('https://fipe.parallelum.com.br/api/v2/cars/brands/7/models'),
  //     headers: {},
  //   );
  //
  //   print(modelsBrandsRespondes.body);
  //
  //   final decoded = jsonDecode(modelsBrandsRespondes.body);
  //   final list = <Vehicle>[];
  //
  //   for (final it in decoded) {
  //     list.add(Vehicle.fromJson(it));
  //   }
  //
  //   print(list);
  // }
}
