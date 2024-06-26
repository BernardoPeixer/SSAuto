import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../controller/vehicle_controller.dart';
import '../model/vehicle_model.dart';

class FleetPageState with ChangeNotifier {
  FleetPageState() {
    loadVehicle();
  }

  final _listVehicles = <Vehicle>[];

  List<Vehicle> get listVehicles => _listVehicles;
  final controllerVehicle = VehicleController();

  Future<void> loadVehicle() async {
    final list = await controllerVehicle.selectVehicles();
    _listVehicles.clear();
    _listVehicles.addAll(list);
    notifyListeners();
  }

  Future<String> getPathImagesCars(String licensePlate) async {
    final appDocumentsDir = await getApplicationSupportDirectory();

    final finalPath = '${appDocumentsDir.path}/images/cars/$licensePlate/0.png';

    return finalPath;
  }
}
