import 'package:flutter/material.dart';
import 'package:ss_auto/controller/vehicle_controller.dart';
import 'package:ss_auto/model/vehicle_model.dart';

import '../controller/agency_controller.dart';
import '../model/agency_model.dart';

/// CREATING THE STATE OF THE CUSTOMER LIST PAGE
class FleetDetailsState with ChangeNotifier {



  /// VEHICLE CONTROLLER FROM DATABASE
  final controllerVehicle = VehicleController();
  /// AGENCY CONTROLLER FROM DATABASE
  final controllerAgency = AgencyController();

  /// GETTER INSTANCE OF VEHICLE

  /// FUNCTION TO UPDATE VEHICLE STATS
  Future<void> updateVehicleStats(int vehicleId, Vehicle vehicle) async {
    if (vehicle.vehicleStats == 'Disponivel') {
      vehicle.vehicleStats = 'Indisponivel';
    } else {
      vehicle.vehicleStats = 'Disponivel';
    }
    await controllerVehicle.updateVehicleStats(
        vehicleId, vehicle.vehicleStats);
    notifyListeners();
  }

  /// FUNCTION TO GET VEHICLE BY ID
  Future<Vehicle?> setVehicle(int? id) async {
    final vehicle = await controllerVehicle.getVehicleById(id!);
    return vehicle;
  }

  /// FUNCTION TO GET AGENCY BY ID
  Future<Agency?> setAgency(int? id) async {
    final agency = await controllerAgency.getAgencyById(id!);
    return agency;
  }
}