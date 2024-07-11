import 'package:flutter/material.dart';
import 'package:ss_auto/controller/vehicle_controller.dart';
import 'package:ss_auto/model/vehicle_model.dart';

class FleetDetailsState with ChangeNotifier {
  final Vehicle? _vehicle;

  final controllerVehicle = VehicleController();

  FleetDetailsState(this._vehicle);

  Vehicle? get vehicle => _vehicle;

  Future<void> updateVehicleStats(int vehicleId) async {
    if (_vehicle!.vehicleStats == 'Disponivel') {
      vehicle!.vehicleStats = 'Indisponivel';
    } else {
      _vehicle.vehicleStats = 'Disponivel';
    }
    await controllerVehicle.updateVehicleStats(
        vehicleId, _vehicle.vehicleStats);
    notifyListeners();
  }
}
